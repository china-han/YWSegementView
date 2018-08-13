//
//  BaseViewController.h
//  YWNabTagDemo
//
//  Created by hyw on 2018/8/13.
//  Copyright © 2018年 bksx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWDetailsTabController.h"
#import "Segement.h"
@interface BaseViewController : UIViewController
- (void)setSegmentView:(YWSegementStyle)segementStyle YWSegementIndicateStyle:(YWSegementIndicateStyle)segementIndicateStyle  isShowSelectView:(BOOL)isShowSelectView;
@end
