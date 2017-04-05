//
//  ThreeTreeModel.h
//  ThreeTreeTable
//
//  Created by xiangronghua on 2017/4/5.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThreeTreeModel : NSObject

@property (assign, nonatomic) BOOL isShow;
@property (strong, nonatomic) NSArray *pois;

/*
 模型数据
 */
- (instancetype)initWithDic:(NSDictionary *)info;

@end
