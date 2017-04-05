//
//  ThreeTreeTableViewCell.m
//  ThreeTreeTable
//
//  Created by xiangronghua on 2017/4/5.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "ThreeTreeTableViewCell.h"

@implementation ThreeTreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(13, 0, 19, 60)];
        [self.contentView addSubview:self.image];
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(45, 8, 183, 21)];
        self.label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.label];
    }
    return self;
}


- (void)setLabelArray:(NSArray *)labelArray {
    
    _labelArray = labelArray;
}

- (void)setCellIndexpath:(NSInteger)cellIndexpath {
    
    _cellIndexpath  = cellIndexpath;
    NSString *str   = [_labelArray objectAtIndex:cellIndexpath];
    self.label.text = str;
    [self setupCellImageView];
}

- (void)setupCellImageView {
    if (_cellIndexpath == _labelArray.count - 1) {
        [self setupImageViewWithString:@"三级圆环"];
        [self.image setContentMode:UIViewContentModeScaleAspectFit];
    } else {
        [self setupImageViewWithString:@"三级圆环"];
        [self.image setContentMode:UIViewContentModeScaleAspectFit];
    }
}

- (void)setupImageViewWithString:(NSString *)string {
    self.image.image = [UIImage imageNamed:string];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
