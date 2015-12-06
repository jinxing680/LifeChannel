//
//  JXCycle.m
//  LifeChannel
//
//  Created by 白金星 on 15/12/2.
//  Copyright © 2015年 cn.bjx680. All rights reserved.
//

#import "JXCycle.h"
#import  <objc/runtime.h>
#import "NetWorkTool.h"
@implementation JXCycle


+ (NSArray *)properties{

    NSMutableArray *properties = [NSMutableArray array];
    // 属性的个数
    unsigned int count = 0;
    //propertyArray 相当于数组
    objc_property_t *propertyArray = class_copyPropertyList([JXCycle class], &count);

    for (int i=0; i <count ; ++i) {
        //获得类中的每一个元素
        objc_property_t property = propertyArray[i];
        // 再获取属性的名称
        const char *cPropertyName = property_getName(property);

        //把C语言中的属性名称转成OC 字符串
        NSString *propertyName = [[NSString alloc]initWithCString:cPropertyName encoding:NSUTF8StringEncoding];
        [properties addObject:propertyName];
    }

    return properties.copy;
}



+ (instancetype)cycleWithDict:(NSDictionary *)dict{

    id obj = [[self alloc]init];
    //获取属性的数组
    NSArray *properties = [self properties];
    for (NSString *propertName in properties) {

        if (dict[propertName]!= nil) {
            [obj setValue:dict[propertName] forKey:propertName];
        }
    }
    return obj;
}


+ (void)headlinesWithFinishedBlock:(FinishedBlock)finishedBlock{
      [[NetWorkTool sharedNetWorkTool]GET:@"ad/headline/0-4.html" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
          NSArray *dictArray = responseObject[@"headline_ad"];
         //字典转模型
          NSMutableArray *cycleList = [NSMutableArray array];

          [dictArray enumerateObjectsUsingBlock:^(NSDictionary  *dict, NSUInteger idx, BOOL * _Nonnull stop) {
              // 字典转成模型
              JXCycle *cycle = [JXCycle cycleWithDict:dict];
            // 加入到数组
              [cycleList addObject:cycle];
          }];
          //传给控制器使用
          if (finishedBlock) {
              finishedBlock(cycleList.copy);
          }

      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"%@",error);

      }];



}

@end
