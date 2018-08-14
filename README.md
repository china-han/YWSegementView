# YWSegementView

一个可以拖拽的二级联动，拖拽完自动交换控制器位置，不会重复加载
<br>
<br>
![image](https://github.com/china-han/YWSegementView/blob/master/1.gif)
![image](https://github.com/china-han/YWSegementView/blob/master/2.gif)
![image](https://github.com/china-han/YWSegementView/blob/master/3.gif)
<br>
<br>
不好意思的是制作GIF图片的时候后面背景没去掉，大家将就一下吧0.0
<br>
#使用方法

因为里面做了拖拽collectionView进行交互，所有你需要把做一个继承自SegmentTitleModel的模型，因为然后把头部标题滚动视图的标题放到模型的title中
并且给出相对应的Controller数组
如下
```
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
```
然后就可以直接创建，并且赋值，设置类型就行
```
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
    [self.view addSubview:segmentView];
}
```
具体大家可以下载demo运行查看
