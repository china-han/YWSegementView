//
//  FourViewController.m
//  YWNabTagDemo
//
//  Created by hyw on 2018/8/13.
//  Copyright © 2018年 bksx. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       [self setSegmentView:YWSegementStyleIndicate YWSegementIndicateStyle:YWSegementIndicateStyleFlush isShowSelectView:NO];
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
