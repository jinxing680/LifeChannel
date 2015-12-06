//
//  JXMainView.h
//  LifeChannel
//
//  Created by 白金星 on 15/12/3.
//  Copyright © 2015年 cn.bjx680. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXMainView : UICollectionView<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic,strong)NSArray *titles;      //标题
@property(nonatomic,strong)NSArray *imageNames;  //未联网时加载的图片名
@property(nonatomic,strong)NSArray *imageData;   //联网时加载的图片数据

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                    imageData:(NSArray *)imageData
                   imageNames:(NSArray *)imageNames;
@end
