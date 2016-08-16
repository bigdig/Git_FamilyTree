//
//  BannerView.m
//  FamilyTree
//
//  Created by 姚珉 on 16/8/9.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "BannerView.h"

@interface BannerView ()<UIScrollViewDelegate>
/** 顶部状态条*/
@property (nonatomic, strong) UIImageView *topStatusIV;
/** 滚动图*/
@property (nonatomic, strong) UIScrollView *bannerSV;
/** 黑色阴影条*/
@property (nonatomic, strong) UIView *backShadowV;
/** 页码*/
@property (nonatomic, strong) UIPageControl *pageControl;
/** 定时器*/
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation BannerView

-(void)dealloc{
    [self.timer invalidate];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initUI];
        self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2.0f];
    }
    return self;
}
#pragma mark - 数据初始化
-(void)initData{
    self.imageStrArr = @[@"sy_banner1",@"sy_banner2",@"sy_banner3"];
}

#pragma mark - 视图初始化
-(void)initUI{
    [self addSubview:self.topStatusIV];
    [self addSubview:self.bannerSV];
    for (int i = 0; i < self.imageStrArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height)];
        imageView.image = MImage(self.imageStrArr[i]);
        [self.bannerSV addSubview:imageView];
    }
    [self addSubview:self.backShadowV];
    [self.backShadowV addSubview:self.pageControl];
}
#pragma mark - 响应方法
-(void)respondsToTimer{
    int page = (int)self.pageControl.currentPage;
    if (page == self.imageStrArr.count - 1) {
        page = 0;
    }else
    {
        page++;
    }
    //  滚动scrollview
    CGFloat x = page * self.bannerSV.frame.size.width;
    [self.bannerSV setContentOffset:CGPointMake(x, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
// 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 暂停timer
    self.timer.fireDate = [NSDate distantFuture];
}

// 停止拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 启动timer
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2.0f];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollviewW =  scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollviewW / 2) /  scrollviewW;
    self.pageControl.currentPage = page;
}



#pragma mark - lazyLoad
-(UIImageView *)topStatusIV{
    if (!_topStatusIV) {
        _topStatusIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectW(self), 22)];
        _topStatusIV.image = MImage(@"sy_statusbg");
    }
    return _topStatusIV;
}


-(UIScrollView *)bannerSV{
    if (!_bannerSV) {
        _bannerSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 22, CGRectW(self), CGRectH(self)-22-2)];
        _bannerSV.contentSize = CGSizeMake(self.frame.size.width*3, self.frame.size.height-22);
        _bannerSV.bounces = NO;
        _bannerSV.pagingEnabled = YES;
        _bannerSV.showsVerticalScrollIndicator = NO;
        _bannerSV.showsHorizontalScrollIndicator = NO;
        _bannerSV.delegate = self;
        
        UIView *blackView = [[UIView alloc]init];
        blackView.backgroundColor = [UIColor blackColor];
        [_bannerSV addSubview:blackView];
        blackView.sd_layout.leftSpaceToView(self,0).rightSpaceToView(self,0).bottomSpaceToView(self,0).heightIs(2);
    }
    return _bannerSV;
}

-(UIView *)backShadowV{
    if (!_backShadowV) {
        _backShadowV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectH(self)-19, CGRectW(self), 19)];
        _backShadowV.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return _backShadowV;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(CGRectW(self)-90, 0, 70, 19)];
        _pageControl.numberOfPages = 3;
        //_pageControl.backgroundColor = [UIColor random];
        _pageControl.currentPageIndicatorTintColor = LH_RGBCOLOR(200, 117, 21);
        _pageControl.tintColor = [UIColor grayColor];
    }
    return _pageControl;
}

-(NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(respondsToTimer) userInfo:nil repeats:YES];
        
    }
    return _timer;
}
@end
