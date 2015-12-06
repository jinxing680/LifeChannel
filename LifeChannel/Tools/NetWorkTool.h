//
//  NetWorkTool.h
//  NewsBoard
//
//  Created by 白金鑫 on 15/11/25.
//
//

#import <AFNetworking/AFNetworking.h>

@interface NetWorkTool : AFHTTPSessionManager

+ (instancetype)sharedNetWorkTool;

@end
