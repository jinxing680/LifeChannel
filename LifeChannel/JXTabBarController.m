//
//  JXTabBarController.m
//  LifeChannel
//
//  Created by 白金星 on 15/12/2.
//  Copyright © 2015年 cn.bjx680. All rights reserved.
//

#import "JXTabBarController.h"
#define KCOUNT  5
@interface JXTabBarController ()
//顶部view
@property (nonatomic,strong)UIView *topView;

//bottomview (底部tabBarView)
@property (nonatomic,strong)UIView *bootomView;

@end

@implementation JXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   //隐藏系统的tabBar
    self.tabBar.hidden = YES;
//
    self.bootomView = [[UIView alloc]initWithFrame:CGRectMake(0, KUIScreenHeight - kUITabBarHeight , KUIScreenWidth, kUITabBarHeight)];
    // 设置botoom的背景色
    self.bootomView.backgroundColor = [UIColor blackColor];
    // 添加到View上
    [self.view addSubview:_bootomView];

    //添加button
    for (int i =0; i < KCOUNT; i++) {
        //button类型
        UIButton *btnItem = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置button的normal图片
        NSString *imgNormal = [NSString stringWithFormat:@"home_%d",i];
        [btnItem setImage:[UIImage imageNamed:imgNormal] forState:UIControlStateNormal];
          //设置button的selected图片
        NSString *imgSelected = [NSString stringWithFormat:@"home_%d_pressed",i];
        [btnItem  setImage:[UIImage imageNamed:imgSelected] forState:UIControlStateSelected];

        //设置按钮的frame
        btnItem.frame = CGRectMake(i * KUIScreenWidth/KCOUNT, 0, KUIScreenWidth/KCOUNT, kUITabBarHeight);
        btnItem.tag = i;
        [btnItem addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
        //添加到botoomView上
        [self.bootomView addSubview:btnItem];

        //默认在第一个
        if(i == 0){
            btnItem.selected = YES;
        }

    }

}


#pragma mark - 点击tabbar按钮的方法
- (void)changeVC:(UIButton *)btn{

    //默认隐藏顶部view
//    _topView.hidden = YES;
    //取消所用选中
    [_bootomView.subviews enumerateObjectsUsingBlock:^(UIButton * historyBtn, NSUInteger idx, BOOL * _Nonnull stop) {

        historyBtn.selected = NO;
    }];

    //当前选中按钮
    btn.selected = YES;
    //前四个更爱状态
    if (btn.tag < 4) {
        self.selectedIndex = btn.tag;
//    }else if (btn.tag == 4){
//
//        //第四个显示topView
//        _topView.hidden = NO;

    }else{
        self.selectedIndex = btn.tag - 1;

    }

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
