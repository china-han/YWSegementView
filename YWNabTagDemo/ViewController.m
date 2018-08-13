//
//  ViewController.m
//  YWNabTagDemo
//
//  Created by hyw on 2018/7/23.
//  Copyright © 2018年 bksx. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *titles;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dateArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSArray *)titles{
//    if (!_titles) {
//        _titles = @[@"推荐",@"娱乐",@"时尚",@"美食",@"美体",@"宠物",@"动漫",@"视频",@"影视",@"星座",@"美妆",@"旅游",@"其他",@"搞笑",@"游戏",@"孕育"];
//    }
//    return _titles;
//}


#pragma mark - UITableViewDelegate,UITableViewDataSource
#pragma tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dateArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentify" forIndexPath:indexPath];
    NSDictionary *dict = self.dateArray[indexPath.row];
    cell.textLabel.text =  dict[@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     NSDictionary *dict = self.dateArray[indexPath.row];
     Class VCClass = NSClassFromString(dict[@"VCClass"]);
      UIViewController *VC = [[VCClass alloc]init];
      [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - lazy loading
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //避免出现iOS11下拉刷新偏移
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedRowHeight = 0;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentify"];
        //去除多余cell的显示
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        //去除分割线
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSArray *)dateArray{
    if (!_dateArray) {
        _dateArray = @[@{@"title":@"指示杆类型,显示拖拽页面，指示杆和按钮的标题齐平",@"VCClass":@"OneViewController"},
                       @{@"title":@"指示杆类型,显示拖拽页面，指示杆和按钮宽度齐平",@"VCClass":@"TwoViewController"},
                       @{@"title":@"指示杆类型,不显示拖拽页面，指示杆和按钮的标题齐平",@"VCClass":@"ThreeViewController"},
                       @{@"title":@"指示杆类型,不显示拖拽页面，指示杆和按钮宽度齐平",@"VCClass":@"FourViewController"},
                       @{@"title":@"间隔类型,不显示拖拽页面",@"VCClass":@"FiveViewController"},
                       @{@"title":@"间隔类型,显示拖拽页面",@"VCClass":@"SixViewController"},];
    }
    return _dateArray;
}

@end
