//
//  YWSelectViewController.h
//  YWNabTagDemo
//
//  Created by hyw on 2018/7/26.
//  Copyright © 2018年 bksx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentTitleModel.h"

@class YWSelectViewController;
@protocol YWSelectViewDelegate <NSObject>

@optional
/**
 交换时调用
 @param sourceIndexPath 原来的IndexPath
 @param destinationIndexPath 将要交换的IndexPath
 */
- (void)exchangeItemSourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;


/**
  重排完成时

 @param newTitles  重排完成后的数据源
 */
- (void)dragCellCollectionViewDidEndDrag:(NSMutableArray <SegmentTitleModel *> *)newTitles;
@optional

@end

@interface YWSelectViewController : UIViewController
@property (nonatomic,strong) NSMutableArray <SegmentTitleModel *> * dataArray;
@property (nonatomic, assign) UICollectionViewScrollDirection collectionViewScrollDirection;
@property (nonatomic,weak) id<YWSelectViewDelegate> delegate;
@end
