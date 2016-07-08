//
//  NewsTableView.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/7.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "NewsTableView.h"

static NSString *const kNesCellIdentifier = @"newscellIdentifier";

@interface NewsTableView()<UITableViewDelegate,UITableViewDataSource>




@end
@implementation NewsTableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initData];
        [self initUI];
    }
    return self;
}
#pragma mark *** 初始化数据 ***
-(void)initData{
//    _dataSource = @[@"湖中有太阳不断被谁打谁打开200人机组",@"湖中有太阳不断被谁打谁打开200人机",@"湖中有太阳不断被谁打谁打开200人机",@"湖中有太阳不断被谁打谁打",@"湖中有断被谁打谁打开200人机组",@"湖中有太阳不断被开200人机组"];
}
#pragma mark *** 初始化界面 ***
-(void)initUI{
    [self addSubview:self.tableView];
}
#pragma mark *** TableView dataSource Delegate ***

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return  self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kNesCellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kNesCellIdentifier];
    }
    cell.familyDTModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark *** getters ***
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[NewsCell class] forCellReuseIdentifier:kNesCellIdentifier];
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.rowHeight = 65*AdaptationWidth();
    }
    return _tableView;
}

@end
