//
//  YWSegmentView.m
//  YWNabTagDemo
//
//  Created by hyw on 2018/7/25.
//  Copyright © 2018年 bksx. All rights reserved.
//

#import "YWSegmentView.h"
#import "YWSegmentViewHeader.h"
#import "YWSelectViewController.h"

@interface YWSegmentView ()<UIScrollViewDelegate,YWSelectViewDelegate>
/** 控制器数组 */
@property (nonatomic, strong) NSMutableArray *viewControllersArr;
/** 标题Btn数组 */
@property (nonatomic, strong) NSMutableArray *BtnArr;
/** 标题数组 */
@property (nonatomic, strong) NSMutableArray <SegmentTitleModel *> *titleArr;
/** segmentView的Size的大小 */
@property (nonatomic, assign) CGSize size;
/** 按钮title到边的间距 */
@property (nonatomic, assign) CGFloat buttonSpace;
/** 父控制器 */
@property (nonatomic, weak) UIViewController *parentViewController;

/** segmentView头部标题视图 */
@property (nonatomic, strong) UIScrollView *segmentTitleView;
/** segmentView控制器视图 */
@property (nonatomic, strong) UIScrollView *segmentContentView;
/** 底部分割线 */
@property (nonatomic, strong) UIView *bottomLineView;

/** 当前被选中的按钮 */
@property (nonatomic, strong) UIButton *selectedButton;
/** 指示杆 */
@property (nonatomic, strong) UIView *indicateView;
/** 按钮宽度（用于SegmentStyle = YWSegementStyleSpace） */
@property (nonatomic, assign) CGFloat button_W;
/** 标题滚动狂bottom */
@property (nonatomic, assign) CGFloat ScrollView_Y;
/** 点击排序按钮 */
@property (nonatomic,strong) UIButton  *sortButton;
/** 类型 */
@property (nonatomic,assign) YWSegementStyle segementStyle;

/** 是否是点击按钮进行滚动 */
@property (nonatomic,assign) BOOL isClickBtn;
/**
 开始颜色,取值范围0~1
 */
@property (nonatomic, assign) CGFloat startR;

@property (nonatomic, assign) CGFloat startG;

@property (nonatomic, assign) CGFloat startB;

/**
 完成颜色,取值范围0~1
 */
@property (nonatomic, assign) CGFloat endR;

@property (nonatomic, assign) CGFloat endG;

@property (nonatomic, assign) CGFloat endB;
@end

static CGFloat Font_Default_size = 0;
static CGFloat Font_Selected_size = 0;
/**<< 默认字体大小 <<*/
#define YW_Font_Default [UIFont boldSystemFontOfSize:Font_Default_size]
/**<< 选中后大小 <<*/
#define YW_Font_Selected [UIFont boldSystemFontOfSize:Font_Selected_size]

@implementation YWSegmentView
{
    CGFloat _currentOffSet;
    yw_indexBlock _yw_resultBlock;
}

- (instancetype)initWithFrame:(CGRect)frame ViewControllersArr:(NSArray *)viewControllersArr TitleArr:(NSArray <SegmentTitleModel *>*)titleArr TitleNormalSize:(CGFloat)titleNormalSize TitleSelectedSize:(CGFloat)titleSelectedSize SegmentStyle:(YWSegementStyle)style ParentViewController:(UIViewController *)parentViewController ReturnIndexBlock: (yw_indexBlock)indexBlock {
    if (self = [super initWithFrame:frame]) {
        [self InitializationProperty];
        _viewControllersArr = [NSMutableArray arrayWithArray:viewControllersArr];
        _titleArr = [NSMutableArray arrayWithArray:titleArr];
        _size = frame.size;
        Font_Default_size = titleNormalSize;
        Font_Selected_size = titleSelectedSize;
        _buttonSpace = [self calculateSpace];
        _parentViewController = parentViewController;
        self.isClickBtn = NO;
        [self loadSegmentTitleViewWithSegmentStyle:style];
        [self addSubview:self.segmentContentView];
        _yw_resultBlock = indexBlock;
    }
    return self;
}


-(void)InitializationProperty{
    _currentOffSet = -1000;
    self.yw_titleNormalColor = YW_NormalColor;
    self.yw_titleSelectedColor = YW_SegmentTintColor;
    
}
- (CGFloat)calculateSpace {
    CGFloat space = 0.f;
    CGFloat totalWidth = 0.f;
    
    for (SegmentTitleModel *model in _titleArr) {
        NSString *title = model.title;
        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : YW_Font_Selected}];
        totalWidth += titleSize.width;
    }
    
    space = (_size.width - totalWidth) / _titleArr.count / 2;
    if (space > YW_MinItemSpace / 2) {
        return space;
    } else {
        return YW_MinItemSpace / 2;
    }
}

- (void)loadSegmentTitleViewWithSegmentStyle:(YWSegementStyle)style {
    self.segementStyle = style;
    [self addSubview:self.segmentTitleView];
    [self addSubview:self.bottomLineView];
    [self.sortButton sizeToFit];
    self.sortButton.frame = CGRectMake(_size.width-self.sortButton.frame.size.width, 0, self.sortButton.frame.size.width, self.sortButton.frame.size.height);
    [self addSubview:self.sortButton];
    self.isShowSelectView = YES;
    CGFloat item_x = 0;
    NSString *title;
    NSMutableArray *mutBtnArr = [NSMutableArray array];
    if (style == YWSegementStyleIndicate) {
        
        for (int i = 0; i < _titleArr.count; i++) {
            SegmentTitleModel *model = _titleArr[i];
            model.tag = @"model".hash + i;
            title = model.title;
            CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName: YW_Font_Selected}];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(item_x, 0, _buttonSpace *2 + titleSize.width, YW_SegmentViewHeight);
            [button setTag:i];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:YW_NormalColor forState:UIControlStateNormal];
            [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
            [_segmentTitleView addSubview:button];
            [mutBtnArr addObject:button];
            item_x += _buttonSpace * 2 + titleSize.width;
            if (i == 0) {
                button.selected = YES;
                _selectedButton = button;
                _selectedButton.titleLabel.font = YW_Font_Selected;
                [button setTitleColor:YW_SegmentTintColor forState:UIControlStateNormal];
                self.indicateView.frame = CGRectMake(_buttonSpace, YW_SegmentViewHeight - YW_IndicateHeight, titleSize.width, YW_IndicateHeight);
                [_segmentTitleView addSubview:_indicateView];
            }else {
                button.titleLabel.font = YW_Font_Default;
            }
        }
    }else if(style == YWSegementStyleSpace){
        _segmentTitleView.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i < _titleArr.count; i++) {
            SegmentTitleModel *model = _titleArr[i];
            model.tag = @"model".hash + i;
            title = model.title;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName: YW_Font_Selected}];
            button.frame = CGRectMake(item_x, 0, _buttonSpace *2 + titleSize.width , YW_SegmentViewHeight);
            [button setTag:i];
            [button setTitle:title forState:UIControlStateNormal];
            button.titleLabel.font = YW_Font_Default;
            [button setTitleColor:YW_NormalColor forState:UIControlStateNormal];
            [button setTitleColor:YW_SegmentTintColor forState:UIControlStateSelected];
            [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
            [_segmentTitleView addSubview:button];
            [mutBtnArr addObject:button];
            
            if (i != _titleArr.count - 1) {
                UIView *spaceLine = [[UIView alloc] init];
                spaceLine.frame = CGRectMake(CGRectGetMaxX(button.frame), 6, YW_Space_W, YW_SegmentViewHeight - 12);
                spaceLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
                [_segmentTitleView addSubview:spaceLine];
            }
            
            item_x = CGRectGetMaxX(button.frame) + YW_Space_W;
        }
    }
    self.BtnArr = [mutBtnArr mutableCopy];
    self.segmentTitleView.contentSize = CGSizeMake(item_x+self.buttonSpace, YW_SegmentViewHeight);
    [self didClickButton:self.BtnArr[0]];
}

- (void)didClickButton:(UIButton *)button {
    if (button != _selectedButton) {
        self.isClickBtn = YES;
        button.selected = YES;
        [button setTitleColor:YW_SegmentTintColor forState:UIControlStateNormal];
        button.titleLabel.font = YW_Font_Selected;
        _selectedButton.selected = !_selectedButton.selected;
        [_selectedButton setTitleColor:YW_NormalColor forState:UIControlStateNormal];
        _selectedButton.titleLabel.font = YW_Font_Default;
        _selectedButton = button;
        [self scrollIndicateView];
        [self scrollSegementView];
    }
}


/**
 根据选中的按钮滑动指示杆
 */
- (void)scrollIndicateView {
    NSInteger index = [self selectedAtIndex];
    CGSize titleSize = [_selectedButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : YW_Font_Selected}];
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:YW_Duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (weakSelf.yw_indicateStyle == YWSegementIndicateStyleDefault) {
            weakSelf.indicateView.frame = CGRectMake(CGRectGetMinX(weakSelf.selectedButton.frame) + weakSelf.buttonSpace, CGRectGetMinY(weakSelf.indicateView.frame), titleSize.width, YW_IndicateHeight);
        } else {
            weakSelf.indicateView.frame = CGRectMake(CGRectGetMinX(weakSelf.selectedButton.frame), CGRectGetMinY(weakSelf.indicateView.frame), [self widthAtIndex:index], YW_IndicateHeight);
        }
        
        [self.segmentContentView setContentOffset:CGPointMake(index * weakSelf.size.width, 0) animated:YES];
    } completion:^(BOOL finished) {
        
    }];
}

/**
 根据选中调整segementView的offset
 */
- (void)scrollSegementView {
    CGFloat selectedWidth = _selectedButton.frame.size.width;
    CGFloat titScroViewW =  self.segmentTitleView.frame.size.width;
    CGFloat offsetX = (_size.width - selectedWidth) / 2;
    if (_selectedButton.frame.origin.x <= titScroViewW / 2) {
        [_segmentTitleView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (CGRectGetMaxX(_selectedButton.frame) >= (_segmentTitleView.contentSize.width - titScroViewW / 2)) {
        [_segmentTitleView setContentOffset:CGPointMake(_segmentTitleView.contentSize.width - titScroViewW, 0) animated:YES];
    } else {
        [_segmentTitleView setContentOffset:CGPointMake(CGRectGetMinX(_selectedButton.frame) - offsetX, 0) animated:YES];
    }
}

#pragma mark -- index
- (NSInteger)selectedAtIndex {
    return _selectedButton.tag;
}

- (CGFloat)widthAtIndex:(NSInteger)index {
    if (index < 0 || index > _titleArr.count - 1) {
        return .0;
    }
    UIButton *btn = self.BtnArr[index];
    return btn.frame.size.width;
}

#pragma mark - 颜色分解

/**
 *  指定颜色，获取颜色的RGB值
 *
 *  @param components RGB数组
 *  @param color      颜色
 */
- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,1,1,8,4,rgbColorSpace,1);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
}

- (void)setupStartColor:(UIColor *)color
{
    CGFloat components[3];
    
    [self getRGBComponents:components forColor:color];
    
    _startR = components[0];
    _startG = components[1];
    _startB = components[2];
}

- (void)setupEndColor:(UIColor *)color
{
    CGFloat components[3];
    
    [self getRGBComponents:components forColor:color];
    
    _endR = components[0];
    _endG = components[1];
    _endB = components[2];
}

//弹窗
-(void)clickSortButton{
    YWSelectViewController *selcetVC = [[YWSelectViewController alloc]init];
    selcetVC.delegate = self;
    selcetVC.dataArray = self.titleArr;
    [self.parentViewController presentViewController:selcetVC animated:YES completion:nil];
}

#pragma mark - YWSelectViewDelegate
/**
 重排完成时
 
 @param newTitles  重排完成后的数据源
 */
- (void)dragCellCollectionViewDidEndDrag:(NSMutableArray <SegmentTitleModel *> *)newTitles{
    NSMutableArray *mutBtnArr = [NSMutableArray array];
    NSMutableArray *VCArr = [NSMutableArray array];
    CGFloat item_x = 0;
    CGFloat vcW = self.segmentContentView.frame.size.width;
    CGFloat vcH = self.segmentContentView.frame.size.height;
    CGFloat vcY = 0;
    //滚动视图
    NSInteger seleBtnIndex = 0;
    if (self.segementStyle == YWSegementStyleIndicate) {
        for (int i=0; i<newTitles.count; i++) {
            for (int j=0; j<self.titleArr.count; j++) {
                if (self.titleArr[j].tag == newTitles[i].tag) {
                    //重排按钮
                    UIButton *button = self.BtnArr[j];
                    button.tag = i;
                    button.frame = CGRectMake(item_x, 0, button.frame.size.width, button.frame.size.height);
                    item_x = CGRectGetMaxX(button.frame);
                    [mutBtnArr addObject:button];
                    if ([self.selectedButton isEqual:button]) {
                        seleBtnIndex = button.tag;
                    }
                    //重排控制器
                    UIViewController *VC = self.viewControllersArr[j];
                    VC.view.frame = CGRectMake(i*vcW, vcY, vcW, vcH);
                    [VCArr addObject:VC];
                }
            }
        }
    }else{
        [self.segmentTitleView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        for (int i=0; i<newTitles.count; i++) {
            for (int j=0; j<self.titleArr.count; j++) {
                if (self.titleArr[j].tag == newTitles[i].tag) {
                    //重排按钮
                    UIButton *button = self.BtnArr[j];
                    button.tag = i;
                    button.frame = CGRectMake(item_x, 0, button.frame.size.width, button.frame.size.height);
                    [mutBtnArr addObject:button];
                    if ([self.selectedButton isEqual:button]) {
                        seleBtnIndex = button.tag;
                    }
                    [self.segmentTitleView addSubview:button];
                    //重排间隔
                    if (i != _titleArr.count - 1) {
                        UIView *spaceLine = [[UIView alloc] init];
                        spaceLine.frame = CGRectMake(CGRectGetMaxX(button.frame), 6, YW_Space_W, YW_SegmentViewHeight - 12);
                        spaceLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
                        [self.segmentTitleView addSubview:spaceLine];
                    }
                    item_x = CGRectGetMaxX(button.frame) + YW_Space_W;
                    //重排控制器
                    UIViewController *VC = self.viewControllersArr[j];
                    VC.view.frame = CGRectMake(i*vcW, vcY, vcW, vcH);
                    [VCArr addObject:VC];
                }
            }
        }
    }
    
    self.selectedButton = nil;
    self.BtnArr = mutBtnArr;
    self.viewControllersArr = VCArr;
    self.titleArr = newTitles;
    self.yw_defaultSelectIndex = seleBtnIndex;
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:didEndDragTitle:)]) {
        [self.delegate segmentView:self didEndDragTitle:newTitles];
    }
}

#pragma mark -- scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.segmentContentView) {
        NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        self.yw_defaultSelectIndex = index;
        if (_yw_resultBlock) {
            _yw_resultBlock(_selectedButton.tag);
            
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:didSelectTitleBtn:)]) {
            [self.delegate segmentView:self didSelectTitleBtn:_selectedButton.tag];
        }
        UIViewController *vc = self.viewControllersArr[index];
        self.isClickBtn = NO;
        if (vc.view.superview) return;
        // 添加
        CGFloat vcW = scrollView.frame.size.width;
        CGFloat vcH = scrollView.frame.size.height;
        CGFloat vcX = index * vcW;
        CGFloat vcY = 0;
        vc.view.frame = CGRectMake(vcX, vcY, vcW, vcH);
        [_parentViewController addChildViewController:vc];
        [scrollView addSubview:vc.view];
        
        
        
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{    self.isClickBtn = NO;
    _currentOffSet = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isClickBtn) {
        return;
    }
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat width = scrollView.frame.size.width;  // --->屏幕的宽度
    // 当前控制器需要显示的控制器的索引
    NSInteger index = offsetX / width;
    NSInteger leftI = index;
    NSInteger rightI = index + 1;
    if (rightI < self.BtnArr.count) {
        CGFloat scaleR = scrollView.contentOffset.x / width;
        scaleR -= leftI;;            //移动的位置和宽度比例 (通常用于右边按钮变化)
        CGFloat scaleL = 1 - scaleR; //未移动的位置和宽度比例 (通常用于左边按钮变化)
        UIButton *leftButton =  self.BtnArr[leftI];
        UIButton *rightButton = self.BtnArr[rightI];
        //文字渐变
        CGFloat fontSize     =  Font_Selected_size - Font_Default_size;
        CGFloat leftBtnFont  = fontSize * scaleL   + Font_Default_size;
        CGFloat rightBtnFont = fontSize * scaleR   + Font_Default_size;
        leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:leftBtnFont];
        rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:rightBtnFont];
        
        if (self.segementStyle == YWSegementStyleIndicate) {
            //下划线渐变
            if (self.yw_indicateStyle == YWSegementIndicateStyleDefault) {
                CGFloat leftX = leftButton.frame.origin.x + self.buttonSpace;
                CGFloat rightX    = rightButton.frame.origin.x + self.buttonSpace;
                CGFloat leftW = leftButton.frame.size.width - 2*self.buttonSpace;
                CGFloat rightW    = rightButton.frame.size.width - 2*self.buttonSpace;
                CGFloat X = (rightX - leftX)*scaleR+leftX;
                CGFloat W = (rightW - leftW)*scaleR+leftW;
                
                _indicateView.frame = CGRectMake(X, _indicateView.frame.origin.y, W, _indicateView.frame.size.height);
            }else{
                CGFloat leftX = leftButton.frame.origin.x;
                CGFloat rightX    = rightButton.frame.origin.x;
                CGFloat leftW = leftButton.frame.size.width;
                CGFloat rightW    = rightButton.frame.size.width;
                
                CGFloat X = (rightX - leftX)*scaleR+leftX;
                CGFloat W = (rightW - leftW)*scaleR+leftW;
                _indicateView.frame = CGRectMake(X, _indicateView.frame.origin.y, W, _indicateView.frame.size.height);
            }
        }
        //颜色渐变
        if (scaleR !=0) {
            CGFloat r = _endR - _startR;
            CGFloat g = _endG - _startG;
            CGFloat b = _endB - _startB;
            
            UIColor *rightColor = [UIColor colorWithRed:_startR + r * scaleR green:_startG + g * scaleR blue:_startB + b * scaleR alpha:1];
            
            UIColor *leftColor = [UIColor colorWithRed:_startR +  r * scaleL  green:_startG +  g * scaleL  blue:_startB +  b * scaleL alpha:1];
            
            [rightButton setTitleColor:rightColor forState:UIControlStateNormal];
            [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
        }
        
    }
    
}

#pragma mark - set
-(void)setIsShowTitleBottomView:(BOOL)isShowTitleBottomView{
    _isShowSelectView = isShowTitleBottomView;
    if (self.indicateView) {
        self.indicateView.hidden = !isShowTitleBottomView;
    }
}

-(void)setIsShowSelectView:(BOOL)isShowSelectView{
    _isShowSelectView = isShowSelectView;
    if (isShowSelectView) {
        self.sortButton.hidden = NO;
        self.segmentTitleView.frame = CGRectMake(0, 0, _size.width-YW_SegmentViewHeight, YW_SegmentViewHeight);
    }else{
        self.sortButton.hidden = YES;
        self.segmentTitleView.frame = CGRectMake(0, 0, _size.width, YW_SegmentViewHeight);
    }
}

-(void)setYw_bgColor:(UIColor *)yw_bgColor{
    _yw_bgColor = yw_bgColor;
    _segmentTitleView.backgroundColor = _yw_bgColor;
}

-(void)setYw_titleNormalColor:(UIColor *)yw_titleNormalColor{
    _yw_titleNormalColor = yw_titleNormalColor;
    [self setupStartColor:yw_titleNormalColor];
    for (UIButton *titleBtn in self.BtnArr) {
        [titleBtn setTitleColor:yw_titleNormalColor forState:UIControlStateNormal];
        
    }
}
-(void)setYw_titleSelectedColor:(UIColor *)yw_titleSelectedColor{
    _yw_titleSelectedColor = yw_titleSelectedColor;
    [self setupEndColor:yw_titleSelectedColor];
    for (UIButton *titleBtn in self.BtnArr) {
        [titleBtn setTitleColor:yw_titleSelectedColor forState:UIControlStateSelected];
    }
}

-(void)setYw_segmentTintColor:(UIColor *)yw_segmentTintColor{
    _yw_segmentTintColor = yw_segmentTintColor;
    _indicateView.backgroundColor = yw_segmentTintColor;
    
}

-(void)setYw_indicateStyle:(YWSegementIndicateStyle)yw_indicateStyle{
    _yw_indicateStyle = yw_indicateStyle;
    if (yw_indicateStyle == YWSegementIndicateStyleDefault) {
        
    }else {
        _indicateView.frame = CGRectMake(_selectedButton.frame.origin.x, YW_SegmentViewHeight - YW_IndicateHeight, [self widthAtIndex:0], YW_IndicateHeight);
    }
}

//- (void)setSelectedItemAtIndex:(NSInteger)index {
//    for (UIView *view in _segmentTitleView.subviews) {
//        if ([view isKindOfClass:[UIButton class]] && view.tag == index) {
//            UIButton *button = (UIButton *)view;
//            [self didClickButton:button];
//        }
//    }
//}

-(void)setYw_defaultSelectIndex:(NSInteger)yw_defaultSelectIndex{
    _yw_defaultSelectIndex = yw_defaultSelectIndex;
    for (UIView *view in _segmentTitleView.subviews) {
        if ([view isKindOfClass:[UIButton class]] && view.tag == yw_defaultSelectIndex) {
            UIButton *button = (UIButton *)view;
            [self didClickButton:button];
        }
    }
}

#pragma mark - get
- (UIScrollView *)segmentTitleView {
    if (!_segmentTitleView) {
        _segmentTitleView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _size.width-YW_SegmentViewHeight, YW_SegmentViewHeight)];
        _segmentTitleView.backgroundColor = YW_SegmentBgColor;
        _segmentTitleView.showsHorizontalScrollIndicator = NO;
        _segmentTitleView.showsVerticalScrollIndicator = NO;
//        self.button_W = (_size.width - YW_Space_W * (_titleArr.count -1)) / _titleArr.count;
        
    }
    return _segmentTitleView;
}

- (UIScrollView *)segmentContentView {
    if (!_segmentContentView) {
        _segmentContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _ScrollView_Y, _size.width, _size.height - _ScrollView_Y)];
//        NSLog(@"ScrollViewVC_HH:%f",_size.height - _ScrollView_Y);
        _segmentContentView.delegate = self;
        _segmentContentView.showsHorizontalScrollIndicator = NO;
        _segmentContentView.pagingEnabled = YES;
        _segmentContentView.bounces = NO;
        [self addSubview:_segmentContentView];
        
        // 设置segmentScrollView的尺寸
        _segmentContentView.contentSize = CGSizeMake(_size.width * self.viewControllersArr.count, 0);
        // 默认加载第一个控制器
        UIViewController *viewController = self.viewControllersArr[0];
        viewController.view.frame = CGRectMake(_size.width * 0, 0, _size.width, _size.height-_ScrollView_Y);
        [_parentViewController addChildViewController:viewController];
        [viewController didMoveToParentViewController:_parentViewController];
        [_segmentContentView addSubview:viewController.view];
    }
    // }
    return _segmentContentView;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, YW_SegmentViewHeight, _size.width, 5)];
        _bottomLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _ScrollView_Y = YW_SegmentViewHeight + 5;
    }
    return _bottomLineView;
}

- (UIView *)indicateView {
    if (!_indicateView) {
        _indicateView = [[UIView alloc] init];
        _indicateView.backgroundColor = YW_SegmentTintColor;
        _indicateView.layer.cornerRadius = YW_IndicateHeight/2;
        _indicateView.layer.masksToBounds = YES;
    }
    return _indicateView;
}

-(UIButton *)sortButton{
    if (!_sortButton) {
        _sortButton = [[UIButton alloc]init];
        [_sortButton setImage:[UIImage imageNamed:@"home_more"] forState:UIControlStateNormal];
        [_sortButton setBackgroundImage:[UIImage imageNamed:@"zhezhao"] forState:UIControlStateNormal];
        [_sortButton addTarget:self action:@selector(clickSortButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sortButton;
}

@end
