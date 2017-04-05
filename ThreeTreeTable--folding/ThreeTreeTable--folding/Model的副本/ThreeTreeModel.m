//
//  ThreeTreeModel.m
//  ThreeTreeTable
//
//  Created by xiangronghua on 2017/4/5.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "ThreeTreeModel.h"

@implementation ThreeTreeModel

- (instancetype)initWithDic:(NSDictionary *)info {
    
    self = [super init];
    if (self) {
        self.pois = info[@"sub"];
    }
    return self;
}

@end
