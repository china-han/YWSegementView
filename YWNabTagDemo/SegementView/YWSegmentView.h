//
//  YWSegmentView.h
//  YWNabTagDemo
//
//  Created by hyw on 2018/7/25.
//  Copyright © 2018年 bksx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentTitleModel.h"
typedef NS_ENUM(NSUInteger, YWSegementStyle ) {
    YWSegementStyleIndicate,   /**<< 指示杆类型 <<*/
    YWSegementStyleSpace      /**<< 间隔类型 <<*/
};

typedef NS_ENUM(NSUInteger, YWSegementIndicateStyle) {
    YWSegementIndicateStyleDefault,    /**<< 指示杆和按钮的标题齐平 <<*/
    YWSegementIndicateStyleFlush      /**<< 指示杆和按钮宽度齐平 <<*/
};

typedef void(^yw_indexBlock)(NSInteger index);

@class YWSegmentView;
@protocol YWSegmentViewDelegate <NSObject>
@optional
-(void)segmentView:(YWSegmentView *)segmentView didSelectTitleBtn:(NSUInteger)seleIndex;

-(void)segmentView:(YWSegmentView *)segmentView didEndDragTitle:(NSMutableArray <SegmentTitleModel *>*)newTitles;
@end

@interface YWSegmentView : UIView
/** 指示杆类型  只有指示杆模式下才有效*/
@property (nonatomic, assign) YWSegementIndicateStyle yw_indicateStyle;
/** 背景颜色 */
@property (nonatomic, strong) UIColor *yw_bgColor;
/** 默认字体颜色 */
@property (nonatomic, strong) UIColor *yw_titleNormalColor;
/** 选中字体颜色 */
@property (nonatomic, strong) UIColor *yw_titleSelectedColor;
/** 选中指示器颜色 */
@property (nonatomic, strong) UIColor *yw_segmentTintColor;
/** 默认选中下标 */
@property (nonatomic, assign) NSInteger yw_defaultSelectIndex;

/** 是否使用拖拽选择功能 */
@property (nonatomic, assign) BOOL isShowSelectView;
@property (nonatomic,weak) id<YWSegmentViewDelegate> delegate;

/**
 通过给定frame，控住器数组，标题数组，segmentView风格,返回segmentView;
 
 @param frame frame
 @param viewControllersArr 控住器数组
 @param titleArr 标题数组 内部必须是SegmentTitleModel
 @param style 风格样式
 @param parentViewController 父控制器
 @param indexBlock 返回点击索引
 @return segmentView
 */
- (instancetype)initWithFrame:(CGRect)frame ViewControllersArr:(NSArray *)viewControllersArr TitleArr:(NSArray <SegmentTitleModel *>*)titleArr TitleNormalSize:(CGFloat)titleNormalSize TitleSelectedSize:(CGFloat)titleSelectedSize SegmentStyle:(YWSegementStyle)style ParentViewController:(UIViewController *)parentViewController ReturnIndexBlock: (yw_indexBlock)indexBlock;


@end
