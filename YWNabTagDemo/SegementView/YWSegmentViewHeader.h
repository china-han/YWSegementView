//
//  YWSegmentViewHeader.h
//  YWNabTagDemo
//
//  Created by hyw on 2018/7/25.
//  Copyright © 2018年 bksx. All rights reserved.
//

#ifndef YWSegmentViewHeader_h
#define YWSegmentViewHeader_h

#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define KScreenWidth [UIScreen mainScreen].bounds.size.width

#define iphoneX  (KScreenHeight==812.0?YES:NO)

#define TabHeight  (iphoneX ? (49+34) : 49)
//纯代码适配齐刘海
#define NavHeight  (iphoneX ? 88 : 64)


/**<< RGB颜色 <<*/
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
/**<< 十六进制颜色 <<*/
#define HEX_COLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

/**<< 头部segementView的高度 <<*/
#define YW_SegmentViewHeight 44.f

/**<< 最小Item之间的间距 <<*/
#define YW_MinItemSpace 20.f

/**<< 标题未被选中时的颜色 <<*/
#define YW_NormalColor [UIColor blackColor]

/**<< 指示杆高度 <<*/
#define YW_IndicateHeight 3.0f

/**<< 间隔宽度 <<*/
#define YW_Space_W 2.0f

/**<< 滑动时间 <<*/
#define YW_Duration .3f

/**<< segment背景颜色 <<*/
#define YW_SegmentBgColor [UIColor whiteColor]

/**<< segmentTintColor <<*/
#define YW_SegmentTintColor [UIColor orangeColor]

#endif /* YWSegmentViewHeader_h */
