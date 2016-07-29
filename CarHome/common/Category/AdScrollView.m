//
//  AdScrollView.m
//  广告循环滚动效果
//
//  Created by QzydeMac on 14/12/20.
//  Copyright (c) 2014年 Qzy. All rights reserved.
//

#import "AdScrollView.h"
#import "UIImageView+WebCache.h"
#import "ADNew1VO.h"

static const long BANNER_IMAGE_TAG_PERFIX = 987650;

#define UISCREENWIDTH  self.bounds.size.width//广告的宽度
#define UISCREENHEIGHT  self.bounds.size.height//广告的高度

#define HIGHT self.bounds.origin.y //由于_pageControl是添加进父视图的,所以实际位置要参考,滚动视图的y坐标

static CGFloat const chageImageTime = 3.0;
static NSUInteger currentImage = 0;//记录中间图片的下标,开始总是为1

@interface AdScrollView ()

{
    //广告的label
//    UILabel * _adLabel;
    //循环滚动的三个视图
    UIImageView * _leftImageView;
    UIImageView * _centerImageView;
    UIImageView * _rightImageView;
    //循环滚动的周期时间
    NSTimer * _moveTime;
    //用于确定滚动式由人导致的还是计时器到了,系统帮我们滚动的,YES,则为系统滚动,NO则为客户滚动(ps.在客户端中客户滚动一个广告后,这个广告的计时器要归0并重新计时)
    BOOL _isTimeUp;
    //为每一个图片添加一个广告语(可选)
//    UILabel * _leftAdLabel;
//    UILabel * _centerAdLabel;
//    UILabel * _rightAdLabel;
}

@property (retain,nonatomic,readonly) UIImageView * leftImageView;
@property (retain,nonatomic,readonly) UIImageView * centerImageView;
@property (retain,nonatomic,readonly) UIImageView * rightImageView;

@end

@implementation AdScrollView
@synthesize adDelegate, bannerArray;
#pragma mark - 自由指定广告所占的frame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
        self.contentSize = CGSizeMake(UISCREENWIDTH * 3, UISCREENHEIGHT);
        self.delegate = self;

        
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_leftImageView];
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_centerImageView];
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH*2, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_rightImageView];
        
        _moveTime = [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
        _isTimeUp = NO;
        
        _centerImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerImageViewTapGesture:)];
        [_centerImageView addGestureRecognizer:tapGestureRecognizer];
        
    }
    return self;
}

#pragma mark - 设置广告所使用的图片(名字)
- (void)setBannerArray:(NSArray *)arr
{
    bannerArray = arr;
    ADNew1VO * leftVO = bannerArray[bannerArray.count - 1];
    ADNew1VO * centerVO = bannerArray[(currentImage)%bannerArray.count];
    ADNew1VO * rightVO = bannerArray[(currentImage+1)%bannerArray.count];
    if ([leftVO.imgurl hasPrefix:@"http"]) {
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:leftVO.imgurl]];
    }else{
        [_leftImageView setImage:[UIImage imageNamed:leftVO.imgurl]];
    }
    
    if ([centerVO.imgurl hasPrefix:@"http"]) {
        [_centerImageView sd_setImageWithURL:[NSURL URLWithString:centerVO.imgurl]];
    }else{
        [_centerImageView setImage:[UIImage imageNamed:centerVO.imgurl]];
    }
    
    if ([rightVO.imgurl hasPrefix:@"http"]) {
        [_rightImageView sd_setImageWithURL:[NSURL URLWithString:rightVO.imgurl]];
    }else{
        [_rightImageView setImage:[UIImage imageNamed:rightVO.imgurl]];
    }
    _centerImageView.tag = BANNER_IMAGE_TAG_PERFIX + currentImage;
}

-(void)setNeedsDisplay{
    [super setNeedsDisplay];
    _pageControl.numberOfPages = bannerArray.count;
    if (bannerArray.count == 1) {
        self.scrollEnabled = NO;
        [_moveTime setFireDate:[NSDate distantFuture]];
        _pageControl.hidden = YES;
    }else{
        self.scrollEnabled = YES;
        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:chageImageTime]];
        _pageControl.hidden = NO;
    }
}

#pragma mark - 创建pageControl,指定其显示样式
- (void)setPageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle
{
    if (_pageControl) {
        [_pageControl removeFromSuperview];
        _pageControl = nil;
    }
    if (PageControlShowStyle == UIPageControlShowStyleNone) {
        return;
    }
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.numberOfPages = bannerArray.count;
    
    if (PageControlShowStyle == UIPageControlShowStyleLeft)
    {
        _pageControl.frame = CGRectMake(10, HIGHT+UISCREENHEIGHT - 20, 20*_pageControl.numberOfPages, 20);
    }
    else if (PageControlShowStyle == UIPageControlShowStyleCenter)
    {
        _pageControl.frame = CGRectMake(0, 0, 20*_pageControl.numberOfPages, 20);
        _pageControl.center = CGPointMake(UISCREENWIDTH/2.0, HIGHT+UISCREENHEIGHT - 10);
    }
    else
    {
        _pageControl.frame = CGRectMake( UISCREENWIDTH - 20*_pageControl.numberOfPages, HIGHT+UISCREENHEIGHT - 20, 20*_pageControl.numberOfPages, 20);
    }
    _pageControl.currentPage = 0;
    
    _pageControl.enabled = NO;
    
    [self performSelector:@selector(addPageControl) withObject:nil afterDelay:0.1f];
}
//由于PageControl这个空间必须要添加在滚动视图的父视图上(添加在滚动视图上的话会随着图片滚动,而达不到效果)
- (void)addPageControl
{
    [[self superview] addSubview:_pageControl];
}

#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage
{
    
    [self setContentOffset:CGPointMake(UISCREENWIDTH * 2, 0) animated:YES];
    _isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

#pragma mark - 图片停止时,调用该函数使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!bannerArray) {
        return;
    }
    if (self.contentOffset.x == 0)
    {
        if (currentImage == 0) {
            currentImage = bannerArray.count - 1;
            _pageControl.currentPage = bannerArray.count - 1;
        }else{
            currentImage = (currentImage-1)%bannerArray.count;
            _pageControl.currentPage = (_pageControl.currentPage - 1)%bannerArray.count;
        }
        
    }
    else if(self.contentOffset.x == UISCREENWIDTH * 2)
    {
       currentImage = (currentImage+1)%bannerArray.count;
       _pageControl.currentPage = (_pageControl.currentPage + 1)%bannerArray.count;
    }
    else
    {
        return;
    }
    
    if (currentImage == 0) {
        ADNew1VO * leftVO = bannerArray[bannerArray.count - 1];
        if ([leftVO.imgurl hasPrefix:@"http"]) {
            [_leftImageView sd_setImageWithURL:[NSURL URLWithString:leftVO.imgurl]];
        }else{
            [_leftImageView setImage:[UIImage imageNamed:leftVO.imgurl]];
        }
    }else{
        ADNew1VO * leftVO = bannerArray[(currentImage-1)%bannerArray.count];
        if ([leftVO.imgurl hasPrefix:@"http"]) {
            [_leftImageView sd_setImageWithURL:[NSURL URLWithString:leftVO.imgurl]];
        }else{
            [_leftImageView setImage:[UIImage imageNamed:leftVO.imgurl]];
        }
    }
    
//    _leftAdLabel.text = _adTitleArray[(currentImage-1)%_imageNameArray.count];
    
    
    ADNew1VO * centerVO = bannerArray[(currentImage)%bannerArray.count];
    if ([centerVO.imgurl hasPrefix:@"http"]) {
        [_centerImageView sd_setImageWithURL:[NSURL URLWithString:centerVO.imgurl]];
    }else{
        [_centerImageView setImage:[UIImage imageNamed:centerVO.imgurl]];
    }
    _centerImageView.tag = BANNER_IMAGE_TAG_PERFIX + currentImage;
    
//    _centerAdLabel.text = _adTitleArray[currentImage%_imageNameArray.count];
    
    ADNew1VO * rightVO = bannerArray[(currentImage+1)%bannerArray.count];
    if ([rightVO.imgurl hasPrefix:@"http"]) {
        [_rightImageView sd_setImageWithURL:[NSURL URLWithString:rightVO.imgurl]];
    }else{
        [_rightImageView setImage:[UIImage imageNamed:rightVO.imgurl]];
    }
    
//    _rightAdLabel.text = _adTitleArray[(currentImage+1)%_imageNameArray.count];
    
    self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
    
    //手动控制图片滚动应该取消那个三秒的计时器
    if (!_isTimeUp) {
        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:chageImageTime]];
    }
    _isTimeUp = NO;
}

-(void)centerImageViewTapGesture:(UIGestureRecognizer *)gesture{
    if ([adDelegate respondsToSelector:@selector(didSelectAtIndex:)]) {
        UIImageView * imageView = (UIImageView *)[gesture view];
        long index = imageView.tag - BANNER_IMAGE_TAG_PERFIX;
        [adDelegate didSelectAtIndex:index];
    }else{
        NSLog(@"no protocol implements");
    }
}

@end

