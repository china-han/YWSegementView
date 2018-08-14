
//
//  YWDetailViewController.m
//  YWNabTagDemo
//
//  Created by hyw on 2018/8/14.
//  Copyright © 2018年 bksx. All rights reserved.
//

#import "YWDetailViewController.h"

@interface YWDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation YWDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
#pragma tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentify" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@---%ld",self.title,(long)indexPath.row];
    cell.textLabel.textColor = [UIColor orangeColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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


@end
