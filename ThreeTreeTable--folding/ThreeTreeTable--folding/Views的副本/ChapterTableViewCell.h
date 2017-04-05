//
//  ChapterTableViewCell.h
//  ThreeTreeTable
//
//  Created by xiangronghua on 2017/4/5.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ThreeTreeModel;
@class ChapterExerciseViewController;

@interface ChapterTableViewCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) NSInteger   cellIndexPath;
@property (strong, nonatomic) NSArray     *cellArray;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UILabel     *chapterName2;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UITableView  *tableView;
@property (strong, nonatomic) NSMutableArray *chapterIdArray;
@property (strong, nonatomic) ChapterExerciseViewController *chapterVC;

- (void)configureCellWithModel:(ThreeTreeModel *)model;

- (void)showTableView;
- (void)hiddenTableView;

@end
