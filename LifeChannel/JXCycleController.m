//
//  JXCycleController.m
//  LifeChannel
//
//  Created by 白金星 on 15/12/2.
//  Copyright © 2015年 cn.bjx680. All rights reserved.
//

#import "JXCycleController.h"
#import "JXCycle.h"
#import "JXCycleCell.h"
#import <PureLayout/PureLayout.h>
#import <objc/runtime.h>

#define MinSection 3


@interface JXCycleController ()

@property (nonatomic ,strong)NSArray *cycleList;

@property (nonatomic,weak)UIPageControl *pageControl;



@end

@implementation JXCycleController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];


    //设置pageControl
    [self setupPageControl];

    //加载数据
    [self loadData];

  

}



- (void)getUIPageControlPrivate{
    NSMutableArray *properties = [NSMutableArray array];

    //我们的一个属性的个数
    unsigned int count = 0;//属性的个数

    //propertyArray 相当于是一个数组
    /**
     class_copyIvarList 这个既可以拿到公有属性,也可以拿到私有属性
     */
    Ivar *propertyArray = class_copyIvarList([UIPageControl class], &count);

    for (int i=0; i<count; i++) {
        //获取到类的每一个属性
        Ivar ivar = propertyArray[i];

        //进一步获取我们属性的名称
        const char *cPropertyName = ivar_getName(ivar);

        //把C语言中的属性名称转成我们OC的字符串
        NSString *propertyName = [[NSString alloc] initWithCString:cPropertyName encoding:NSUTF8StringEncoding];

        NSLog(@"%@",propertyName);

        [properties addObject:propertyName];
    }

    free(propertyArray);
}


#pragma mark -加载数据
- (void)loadData{

    __weak typeof(self) weakSelf = self;
  [JXCycle headlinesWithFinishedBlock:^(NSArray *cycleList) {
      weakSelf.cycleList = cycleList;
      //设置总页数
      weakSelf.pageControl.numberOfPages = cycleList.count;
  }];

}

#pragma mark - 设置pageControl
- (void)setupPageControl{

    // 创建一个pageControl
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.pageIndicatorTintColor = [UIColor blueColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];

   // 添加到父控件,使用PureLayout之前一定要先加到父空间上
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;

    //3.利用PureLayout控件设置pageControl约束
    [pageControl autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-10];
    [pageControl autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view withOffset:3];
    //[pageControl autoSetDimensionsToSize:CGSizeMake(100, 30)];//设置尺寸

     //设置图片,来替换系统的圆圈
    [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"_pageImage"];
    [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];

}

- (void)setCycleList:(NSArray *)cycleList{
    _cycleList = cycleList;

        //刷新表格
        [self.collectionView reloadData];

        //1.通过无动画的方式,自动滚动到最中间的那组去
        //2.创建最中的那组
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:MinSection / 2 ];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return MinSection;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.cycleList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JXCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CycleCell" forIndexPath:indexPath];
    
    // Configure the cell
    cell.cycle = self.cycleList[indexPath.item];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    //通过无动画的方式,切换到最中间那组去]
    int currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;

    currentPage = currentPage % self.cycleList.count;

    self.pageControl.currentPage = currentPage;

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentPage inSection:MinSection/2];

    //通过无动画的方式,切换回中间那组
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];

}


@end
