//
//  YWSelectViewController.m
//  YWNabTagDemo
//
//  Created by hyw on 2018/7/26.
//  Copyright © 2018年 bksx. All rights reserved.
//

#import "YWSelectViewController.h"
#import "YWSelectCollectionViewCell.h"
#import "HYDragCellCollectionView.h"
#import "YWSegmentViewHeader.h"
#define backColor  [UIColor groupTableViewBackgroundColor]
@interface YWSelectViewController ()<YWDragCellCollectionViewDelegate,YWDragCollectionViewDataSource>
@property (nonatomic,strong) YWDragCellCollectionView *collectionView;
@end

@implementation YWSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeadView];
    self.view.backgroundColor =  backColor;
    self.collectionView.frame = CGRectMake(0, NavHeight+44, self.view.bounds.size.width, self.view.bounds.size.height-NavHeight - 44 );
    [self.view addSubview:self.collectionView];
}

-(void)setHeadView{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = backColor;
    headView.frame = CGRectMake(0, NavHeight, self.view.bounds.size.width, 44);
    [self.view addSubview:headView];
    
    UILabel *titLable = [[UILabel alloc]init];
    titLable.text = @"长按拖拽";
    titLable.font = [UIFont systemFontOfSize:14];
    titLable.frame = CGRectMake(20, 0, headView.frame.size.width-80, headView.frame.size.height);
    [headView addSubview:titLable];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    closeBtn.frame = CGRectMake(headView.frame.size.width-60, 6, 40,  25);
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    UIColor *btnColor = [UIColor redColor];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [closeBtn setTitleColor:btnColor forState:UIControlStateNormal];
    closeBtn.layer.cornerRadius = 5;
    closeBtn.layer.borderColor = btnColor.CGColor;
    closeBtn.layer.borderWidth = 1;
    closeBtn.layer.masksToBounds = YES;
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:closeBtn];
}

-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(1000 , 44);
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14] ,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    SegmentTitleModel *model = self.dataArray[indexPath.row];
    CGSize actualsize = [model.title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    return CGSizeMake(actualsize.width+20, actualsize.height+20);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YWSelectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemId" forIndexPath:indexPath];
    SegmentTitleModel *model = self.dataArray[indexPath.row];
    cell.text = model.title;
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (NSArray *)dataSourceWithDragCellCollectionView:(YWDragCellCollectionView *)dragCellCollectionView {
    return self.dataArray;
}

- (void)dragCellCollectionView:(YWDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray *)newDataArray {
    self.dataArray = [newDataArray mutableCopy];
}

/**
 重排完成时
 Rearrangement complete
 
 @param dragCellCollectionView dragCellCollectionView
 */
- (void)dragCellCollectionViewDidEndDrag:(YWDragCellCollectionView *)dragCellCollectionView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dragCellCollectionViewDidEndDrag:)]) {
        [self.delegate dragCellCollectionViewDidEndDrag:self.dataArray];
    }
}

- (YWDragCellCollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.scrollDirection = self.collectionViewScrollDirection;
        _collectionView = [[YWDragCellCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        if (self.dataArray.count > 1) {
//            layout.headerReferenceSize = CGSizeMake(100, 100);
        }
        if (self.collectionViewScrollDirection == UICollectionViewScrollDirectionVertical) {
            _collectionView.alwaysBounceVertical = YES;
        } else {
            _collectionView.alwaysBounceHorizontal = YES;
        }
        [_collectionView registerClass:[YWSelectCollectionViewCell class] forCellWithReuseIdentifier:@"itemId"];
        _collectionView.backgroundColor = backColor;
    }
    return _collectionView;
}

@end
