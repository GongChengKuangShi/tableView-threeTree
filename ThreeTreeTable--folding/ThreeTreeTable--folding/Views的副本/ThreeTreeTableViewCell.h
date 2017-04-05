//
//  ThreeTreeTableViewCell.h
//  ThreeTreeTable
//
//  Created by xiangronghua on 2017/4/5.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeTreeTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UILabel     *label;

@property (strong, nonatomic) NSArray    *labelArray;
@property (assign, nonatomic) NSInteger   cellIndexpath;

@end
