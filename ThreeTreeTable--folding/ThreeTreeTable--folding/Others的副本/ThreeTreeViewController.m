//
//  ThreeTreeViewController.m
//  ThreeTreeTable
//
//  Created by xiangronghua on 2017/4/5.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "ThreeTreeViewController.h"
#import "ThreeTreeTableViewCell.h"
#import "Common.h"
#import "ThreeTreeModel.h"
#import "ChapterTableViewCell.h"
#import "ChapterHeader.h"

@interface ThreeTreeViewController ()<UITableViewDelegate,UITableViewDataSource,ChapterHeaderDelegate> {
    
    NSInteger currentSection;
    NSInteger currenRow;
}
//tableView 显示的数据
@property (strong, nonatomic) NSArray *dataSource;

//标记section的打开状态
@property (strong, nonatomic) NSMutableArray *sectionOpen;

@property (strong, nonatomic) NSMutableDictionary *cellOpen;

//标记section内标题的情况
@property (nonatomic, strong) NSArray *sectionArray;

@end

@implementation ThreeTreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    currenRow = -1;
    
    self.cellOpen   = [NSMutableDictionary dictionary];
    self.dataSource = [[NSMutableArray alloc] init];
    //取代tableView的分割线
    self.tableView.separatorColor = UITableViewCellSeparatorStyleNone;
    
    NSString *filePath   = [[NSBundle mainBundle] pathForResource:@"json" ofType:nil];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    self.dataSource      = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    
    self.sectionOpen = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.dataSource.count; i++) {
        [self.sectionOpen addObject:@0];
    }
    
    for (NSDictionary *dic1 in self.dataSource) {
        NSArray *arr2 = dic1[@"sub"];
        for (NSDictionary *dic2 in arr2) {
            NSString *key = [NSString stringWithFormat:@"%@",dic2[@"chapterID"]];
            ThreeTreeModel *model = [[ThreeTreeModel alloc] initWithDic:dic2];
            model.isShow = NO;
            [self.cellOpen setValue:model forKey:key];
        }
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    [self.tableView reloadData];
    
    NSLog(@"self.cellOpen == %@",self.cellOpen);
}

#pragma mark -- TableViewDelegate And  TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    BOOL sectionStatus = [self.sectionOpen[section] boolValue];
    if (sectionStatus) {
        
        //数据决定显示多少行cell
        NSDictionary *sectionDic = self.dataSource[section];
        //section决定cell的数据
        NSArray *cellArray = sectionDic[@"sub"];
        return cellArray.count;
    } else {
        //section是收起状态时候
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    ChapterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ChapterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *sectionDic = self.dataSource[indexPath.section];
    NSArray *cellArray = sectionDic[@"sub"];
    NSDictionary *cellData = cellArray[indexPath.row];
    
    NSString *key = [NSString stringWithFormat:@"%@",cellData[@"chapterID"]];
    ThreeTreeModel *chapterModel = [self.cellOpen valueForKey:key];
    //cell当前数据
    
    cell.cellArray = cellArray;
    NSLog(@"indexPath.row == %ld",indexPath.row);
    cell.cellIndexPath = indexPath.row;
    [cell configureCellWithModel:chapterModel];
    cell.chapterName2.text = cellData[@"chapterName"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *sectionDic = self.dataSource[indexPath.section];
    NSArray *cellArray = sectionDic[@"sub"];
    //cell当前的数据
    NSDictionary *cellData = cellArray[indexPath.row];
    NSString *key = [NSString stringWithFormat:@"%@",cellData[@"chapterID"]];
    ThreeTreeModel *model  = [self.cellOpen valueForKey:key];
    if (model.isShow) {
        return (model.pois.count + 1) * 60;
    } else {
        return 60.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ChapterHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"ChapterHeader" owner:self options:nil] lastObject];
    header.frame = CGRectMake(0, 0, kScreen_Width, 60);
    header.dataArray = self.dataSource;
    header.section   = section;
    header.sectionStatus = [self.sectionOpen[section] boolValue];
    header.delegate = self;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    currenRow = indexPath.row;
    NSDictionary *sectionDic = self.dataSource[indexPath.section];
    NSArray *cellArray = sectionDic[@"sub"];
    
    //cell当前的数据
    NSDictionary *cellData = cellArray[indexPath.row];
    
    NSString *key = [NSString stringWithFormat:@"%@",cellData[@"chapterID"]];
    ThreeTreeModel *chapterModel = [self.cellOpen valueForKey:key];
    
    chapterModel.isShow = !chapterModel.isShow;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark -- headerViewDelegate
- (void)didTouchOpenButtonAction:(UIButton *)button view:(ChapterHeader *)header{
    currentSection = button.tag;
    //tableView收起，局部刷新
    NSNumber *sectionStatus = self.sectionOpen[[button tag]];
    BOOL newSection = ![sectionStatus boolValue];
    header.sectionStatus = newSection;
    [self.sectionOpen replaceObjectAtIndex:[button tag] withObject:[NSNumber numberWithBool:newSection]];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[button tag]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
