//
//  ChapterHeader.m
//  ThreeTreeTable
//
//  Created by xiangronghua on 2017/4/5.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "ChapterHeader.h"
#import "Common.h"

@implementation ChapterHeader

- (void)setSection:(NSInteger)section {
    
    _section = section;
}

- (void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = dataArray;
    
}

- (void)setSectionStatus:(BOOL)sectionStatus {
    
    _sectionStatus = sectionStatus;
    [self loadData];
}

- (void)loadData {
    
    NSDictionary *dictionary = [self.dataArray objectAtIndex:_section];
    self.chapterName.text = dictionary[@"chapterName"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.25)];
    view.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    [self addSubview:view];
    [self.openButton addTarget:self action:@selector(sectionAction:) forControlEvents:UIControlEventTouchUpInside];
    self.openButton.tag = _section;
    
    [self setupImageStatus];
}

- (void)setupImageStatus {
    
    NSDictionary *dic = [_dataArray objectAtIndex:_section];
    //点击标题变换图片
    if (_sectionStatus) {
        //章节添加横线，选中加阴影
        //直接取出datasource的section,检查返回数据中是否有ksub
        if ([dic.allKeys indexOfObject:@"sub"] != NSNotFound) {
            self.imageView.image = [UIImage imageNamed:@"一级减号"];
            [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        } else {
            self.imageView.image = [UIImage imageNamed:@"一级圆"];
            [self.imageView setContentMode:UIViewContentModeTop];
        }
    } else {
        if ([dic.allKeys indexOfObject:@"sub"] != NSNotFound) {
            self.imageView.image = [UIImage imageNamed:@"一级圆环加号"];
            [self.imageView setContentMode:UIViewContentModeTop];
        } else {
            self.imageView.image = [UIImage imageNamed:@"一级圆"];
            [self.imageView setContentMode:UIViewContentModeTop];
        }
    }
}

- (void)sectionAction:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(didTouchOpenButtonAction:view:)]) {
        [self.delegate didTouchOpenButtonAction:button view:self];
    }
}


@end
