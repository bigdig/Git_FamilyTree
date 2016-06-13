//
//  PersonalCenterInfoView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/6/4.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "PersonalCenterInfoView.h"

@interface PersonalCenterInfoView()
/** 头像视图*/
@property (nonatomic, strong) UIImageView *headIV;
/** 信息数组*/
@property (nonatomic, strong) NSArray *infoArr;
/** 当前族谱名*/
@property (nonatomic, copy) NSString *currentFamilyTreeName;
/** 当前族谱标签*/
@property (nonatomic, strong) UILabel *currentFamilyTreeNameLB;
/** 弹出切换家谱视图*/
@property (nonatomic, strong) UIView *changeFamilyTreeView;
/** 切换家谱名数组*/
@property (nonatomic, strong) NSArray *changeFamilyTreeNameArr;
@end

@implementation PersonalCenterInfoView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //背景图
        UIImageView *bgIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, CGRectH(self))];
        bgIV.image = MImage(@"gr_ct_qieHuanJiaPu_bg");
        [self addSubview:bgIV];
        //头像
        [self initHeadIV];
        self.headIV.image = MImage(@"gr_ct_qieHuanJiaPu_tx");
        //4个信息标签
        self.infoArr = @[@"排\n行\n三",@"字\n辈\n\n安",@"第\n一\n三\n八\n代",@"陈\n安\n一"];
        [self initFourLBs];
        //怀宁陈氏标签和切换家谱按钮
        self.currentFamilyTreeName = @"怀\n宁\n陈\n氏";
        [self initFamilyTreeNameLBAndChangeFamilyTreeLB];
        //设置弹出切换家谱界面
        [self addSubview:self.changeFamilyTreeView];
        
    }
    return self;
}

-(void)initHeadIV{
    self.headIV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 80, 80)];
    [self addSubview:self.headIV];
}

-(void)initFourLBs{
    for (int i = 0; i < 4; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.font = MFont(16);
        label.text = self.infoArr[i];
        [self labelHeightToFit:label andFrame:CGRectMake(0.380*Screen_width+(0.0938*Screen_width+0.0063*Screen_width)*i, 0.1630*CGRectH(self), 0.0938*Screen_width, 200)];
        [self addSubview:label];
    }
}

-(void)initFamilyTreeNameLBAndChangeFamilyTreeLB{
    self.currentFamilyTreeNameLB = [[UILabel alloc]init];
    self.currentFamilyTreeNameLB.font = MFont(12);
    self.currentFamilyTreeNameLB.textColor = [UIColor whiteColor];
    self.currentFamilyTreeNameLB.text = self.currentFamilyTreeName;
    [self labelHeightToFit:self.currentFamilyTreeNameLB andFrame:CGRectMake(0.8113*Screen_width, 0.2174*CGRectH(self), 0.0469*Screen_width, 200)];
    [self addSubview:self.currentFamilyTreeNameLB];
    
    //切换家谱
    UILabel *changeFamilyTreeLB = [[UILabel alloc]init];
    changeFamilyTreeLB.font = MFont(12);
    changeFamilyTreeLB.text = @"切\n换\n家\n谱";
    [self labelHeightToFit:changeFamilyTreeLB andFrame:CGRectMake(0.9259*Screen_width, 0.2174*CGRectH(self), 0.0469*Screen_width, 200)];
    [self addSubview:changeFamilyTreeLB];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickChangeFamilyTreeName:)];
    changeFamilyTreeLB.userInteractionEnabled = YES;
    [changeFamilyTreeLB addGestureRecognizer:tap];
    
}

-(void)initFamilyTreeNameBtns{
    for (int i = 0; i < 6; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0.7863*Screen_width-(0.0938*Screen_width+0.0063*Screen_width)*i, 0, 0.0938*Screen_width, CGRectH(self))];
        //btn.backgroundColor = [UIColor redColor];
        [btn setBackgroundImage:MImage(@"gr_ct_qieHuanJiaPu_bg_a") forState:UIControlStateNormal];
        if (i < self.changeFamilyTreeNameArr.count) {
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 40, 0);
            btn.titleLabel.numberOfLines = 0;
            btn.titleLabel.font = MFont(12);
            [btn setTitle: self.changeFamilyTreeNameArr[i] forState:UIControlStateNormal];
        }
        btn.tag = 51+i;
        [btn addTarget:self action:@selector(clickFamilyTreeNameToChange:) forControlEvents:UIControlEventTouchUpInside];
        btn.userInteractionEnabled = YES;
        [self.changeFamilyTreeView addSubview:btn];
    }
}
#pragma mark - lazyLoad
-(UIView *)changeFamilyTreeView{
    if (!_changeFamilyTreeView) {
        _changeFamilyTreeView = [[UIView alloc]init];
        _changeFamilyTreeView.backgroundColor = [UIColor clearColor];
//        _changeFamilyTreeView.backgroundColor = [UIColor redColor];
    }
    return _changeFamilyTreeView;
}

-(NSArray *)changeFamilyTreeNameArr{
    if (!_changeFamilyTreeNameArr) {
        _changeFamilyTreeNameArr = @[@"怀\n宁\n陈\n氏",@"怀\n宁\n张\n氏",@"怀\n宁\n王\n氏",@"怀\n宁\n姚\n氏",@"怀\n宁\n符\n氏"];
    }
    return _changeFamilyTreeNameArr;
}

-(void)clickChangeFamilyTreeName:(UILabel *)sender{
    //设置切换家谱弹出动画
    WK(weakSelf);
    if (self.changeFamilyTreeView.frame.size.width == 0) {
        self.changeFamilyTreeView.frame = CGRectMake(0.8781*Screen_width,0,0,CGRectH(self));
        [UIView animateWithDuration:1 animations:^{
            [self addSubview:self.changeFamilyTreeView];
            weakSelf.changeFamilyTreeView.frame = CGRectMake(0, 0, 0.8781*Screen_width, CGRectH(self));
            [self initFamilyTreeNameBtns];
        }];
    }else{
        [UIView animateWithDuration:1 animations:^{
            weakSelf.changeFamilyTreeView.frame = CGRectMake(0.8781*Screen_width,0,0,CGRectH(self));
        }];
    }
}

-(void)clickFamilyTreeNameToChange:(UIButton *)sender{
    self.currentFamilyTreeName = self.changeFamilyTreeNameArr[sender.tag-51];
    self.currentFamilyTreeNameLB.text = self.currentFamilyTreeName;
    WK(weakSelf);
    [UIView animateWithDuration:1 animations:^{
        weakSelf.changeFamilyTreeView.frame = CGRectMake(0.8781*Screen_width,0,0,CGRectH(self));
    }];
}

//高度自适应
-(void)labelHeightToFit:(UILabel *)label andFrame:(CGRect)frame{
    label.numberOfLines = 0;//根据最大行数需求来设置
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(100, 9999);//labelsize的最大值
    //关键语句
    CGSize expectSize = [label sizeThatFits:maximumLabelSize];
    label.frame = CGRectMake(frame.origin.x,frame.origin.y,frame.size.width, expectSize.height);

}
@end
