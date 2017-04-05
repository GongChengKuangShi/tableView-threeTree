//
//  ChapterTableViewCell.m
//  ThreeTreeTable
//
//  Created by xiangronghua on 2017/4/5.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "ChapterTableViewCell.h"
#import "ThreeTreeModel.h"
#import "Common.h"
#import "ThreeTreeViewController.h"
#import "AppDelegate.h"
#import "ThreeTreeTableViewCell.h"

@implementation ChapterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];


}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        self.dataArray = [[NSMutableArray alloc] init];
        self.chapterIdArray = [[NSMutableArray alloc] init];
        [self addAllViews];
    }
    return self;
}

- (void)setCellArray:(NSArray *)cellArray {
    _cellArray = cellArray;
}

- (void)setCellIndexPath:(NSInteger)cellIndexPath {
    _cellIndexPath = cellIndexPath;
}

- (UIImageView *)imageView2 {
    
    if (!_imageView2) {
        
        _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(13, -4, 19, 64)];
        [self.contentView addSubview:_imageView2];
    }
    return _imageView2;
}

- (UILabel *)chapterName2 {
    
    if (!_chapterName2) {
        _chapterName2 = [[UILabel alloc] initWithFrame:CGRectMake(45, 8, 183, 21)];
        _chapterName2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_chapterName2];
    }
    return _chapterName2;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 59, kScreen_Width, 1) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled  = NO;
        _tableView.delegate       = self;
        _tableView.dataSource     = self;
    }
    return _tableView;
}

- (void)addAllViews {
    [self.tableView registerClass:[ThreeTreeTableViewCell class] forCellReuseIdentifier:@"testCell"];
}

- (void)showTableView {
    
    [self.contentView addSubview:_tableView];
}

- (void)hiddenTableView {
    
    [_tableView removeFromSuperview];
}

- (void)configureCellWithModel:(ThreeTreeModel *)model {
    
    [self.dataArray removeAllObjects];
    NSArray *array = model.pois;
    for (NSDictionary *dict in array) {
        NSString *str = dict[@"chapterName"];
        [self.dataArray addObject:str];
        
        NSString *chapterID = dict[@"chapterID"];
        [self.chapterIdArray addObject:chapterID];
    }
    [self setupCellContentWithModel:model];
    [self cellIsSelectedWithModel:model];
    CGRect frame = self.tableView.frame;
    frame.size.height = 60 * array.count;
    self.tableView.frame = frame;
    [self.tableView reloadData];
}

- (void)setupCellContentWithModel:(ThreeTreeModel *)model {
    NSLog(@"_cellIndexPath == %ld",_cellIndexPath);
    NSLog(@"_cellArray.count - 1 == %ld",_cellArray.count - 1);
    if (_cellIndexPath == _cellArray.count - 1) {
        if (model.pois.count == 0) {
            [self setupImageView2WithString:@"二级圆尾"];
        } else {
            if (!model.isShow) {
                [self setupImageView2WithString:@"二级圆环-尾加"];
            } else {
                [self setupImageView2WithString:@"三级圆环减"];
            }
        }
        
        [self.imageView2 setContentMode:UIViewContentModeScaleAspectFit];
        
    } else {
        if (model.pois.count == 0) {
            [self setupImageView2WithString:@"zhongjian"];
        } else {
            if (!model.isShow) {
                [self setupImageView2WithString:@"二级加号"];
            } else {
                [self setupImageView2WithString:@"三级圆环减"];
            }
        }
        [self.imageView2 setContentMode:UIViewContentModeScaleAspectFit];
    }
    
}

- (void)setupImageView2WithString:(NSString *)string {
    self.imageView2.image = [UIImage imageNamed:string];
}

- (void)cellIsSelectedWithModel:(ThreeTreeModel *)model {
    if (model.isShow == YES) {
        [self showTableView];
    } else {
        [self hiddenTableView];
    }
}

#pragma mark -- TableViewDelegate And  TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ThreeTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ThreeTreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"testCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.labelArray = self.dataArray;
    cell.cellIndexpath = indexPath.row;
    return cell;
}


@end
