//
//  JXCycleCell.m
//  LifeChannel
//
//  Created by 白金星 on 15/12/2.
//  Copyright © 2015年 cn.bjx680. All rights reserved.
//

#import "JXCycleCell.h"
#import <UIImageView+AFNetworking.h>
#import "JXCycle.h"
@interface JXCycleCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation JXCycleCell

- (void)setCycle:(JXCycle *)cycle{

    _cycle = cycle;

    [self.iconView  setImageWithURL:[NSURL  URLWithString:cycle.imgsrc]];
    self.titleLabel.text = cycle.title;



}

@end
