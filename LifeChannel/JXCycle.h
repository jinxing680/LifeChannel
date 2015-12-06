//
//  JXCycle.h
//  LifeChannel
//
//  Created by 白金星 on 15/12/2.
//  Copyright © 2015年 cn.bjx680. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FinishedBlock)(NSArray *cycleList);

@interface JXCycle : NSObject

//标题
@property (nonatomic,copy)NSString *title;
//图片
@property (nonatomic,copy)NSString *imgsrc;


// 返回轮播需要的数据

+ (void)headlinesWithFinishedBlock:(FinishedBlock)finishedBlock;

@end
