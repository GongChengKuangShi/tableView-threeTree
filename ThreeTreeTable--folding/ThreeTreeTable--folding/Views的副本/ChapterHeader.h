//
//  ChapterHeader.h
//  ThreeTreeTable
//
//  Created by xiangronghua on 2017/4/5.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChapterHeader;

@protocol ChapterHeaderDelegate <NSObject>
@optional

- (void)didTouchOpenButtonAction:(UIButton *)button view:(ChapterHeader *)header;

@end

@interface ChapterHeader : UIView

@property (weak, nonatomic) IBOutlet UILabel *chapterName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *openButton;

@property (strong, nonatomic) NSArray *dataArray;
@property (assign, nonatomic) BOOL sectionStatus;
@property (assign, nonatomic) NSInteger section;
@property (weak, nonatomic) id<ChapterHeaderDelegate> delegate;

@end
