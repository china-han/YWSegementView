//
//  BaseViewController.m
//  YWNabTagDemo
//
//  Created by hyw on 2018/8/13.
//  Copyright © 2018年 bksx. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setSegmentView:(YWSegementStyle)segementStyle YWSegementIndicateStyle:(YWSegementIndicateStyle)segementIndicateStyle  isShowSelectView:(BOOL)isShowSelectView{
    NSMutableArray *mutArr = [NSMutableArray array];
    NSMutableArray *titleArr = [NSMutableArray array];
    NSArray *titles = @[@"精选",@"2018世界杯",@"明日之子",@"电影",@"电视剧",@"NBA",@"花样年华"];
    for (int i = 0; i < 7; i++) {
        YWDetailsTabController *tabVC = [YWDetailsTabController new];
        tabVC.title = titles[i];
        [mutArr addObject:tabVC];
        
        SegmentTitleModel *model = [[SegmentTitleModel alloc]init];
        model.title = titles[i];
        [titleArr addObject:model];
    }
    YWSegmentView *segmentView = [[YWSegmentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame)) ViewControllersArr:[mutArr copy] TitleArr:titleArr TitleNormalSize:16 TitleSelectedSize:20 SegmentStyle:segementStyle ParentViewController:self ReturnIndexBlock:^(NSInteger index) {
        NSLog(@"点击了%ld模块",(long)index);
    }];
    segmentView.yw_indicateStyle = segementIndicateStyle;
    segmentView.isShowSelectView = isShowSelectView;
    segmentView.isShowTitleBottomView = YES;
    [self.view addSubview:segmentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
