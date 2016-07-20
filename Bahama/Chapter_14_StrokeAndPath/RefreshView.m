//
//  RefreshView.m
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import "RefreshView.h"

@interface RefreshView()

@property(nonatomic, weak) CAShapeLayer *ovalShapeLayer;
@property(nonatomic, weak) CALayer *airplaneLayer;
@property(nonatomic, assign) CGFloat progress;
@property(nonatomic, assign) BOOL isRefreshing;
@property(nonatomic, strong) UIScrollView *scrollView;

@end

@implementation RefreshView

- (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)scrollView
{
    if (self = [super initWithFrame:frame]) {
        [self setup:scrollView];
    }
    return self;
}

- (void)setup:(UIScrollView *)scrollView
{
    self.scrollView = scrollView;
    //添加背景图片
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refresh-view-bg"]];
    bgView.frame = self.bounds;
    bgView.contentMode = UIViewContentModeScaleToFill;
    bgView.clipsToBounds = YES;
    [self addSubview:bgView];
    
    //添加圆圈
    CAShapeLayer *ovalShapeLayer = [CAShapeLayer layer];
    ovalShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    ovalShapeLayer.fillColor = [UIColor clearColor].CGColor;
    ovalShapeLayer.lineWidth = 4.0;
    ovalShapeLayer.lineDashPattern = @[@(2),@(3)];
    CGFloat radius = self.frame.size.height * 0.5 * 0.8;
    NSLog(@"center %@",NSStringFromCGPoint(self.center));
    ovalShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.bounds.size.width * 0.5 - radius, self.bounds.size.height * 0.5 - radius, radius * 2, radius * 2)].CGPath;
    self.ovalShapeLayer = ovalShapeLayer;
    [self.layer addSublayer:ovalShapeLayer];
    
    //添加小飞机
    CALayer *airplaneLayer = [CALayer layer];
    UIImage *airplaneImage = [UIImage imageNamed:@"icon-plane"];
    airplaneLayer.contents = (__bridge id _Nullable)(airplaneImage.CGImage);
    airplaneLayer.frame = CGRectMake(self.frame.size.width * 0.5 + radius, self.frame.size.height * 0.5, airplaneImage.size.width, airplaneImage.size.height);
    airplaneLayer.position = CGPointMake(self.frame.size.width * 0.5 + radius, self.frame.size.height * 0.5);
    self.airplaneLayer = airplaneLayer;
    self.airplaneLayer.opacity = 0.0;
    [self.layer addSublayer:airplaneLayer];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //contentOffset.y = -64  scrollView.contentInset.top = 64
    CGFloat offset = MAX(-(scrollView.contentOffset.y + scrollView.contentInset.top), 0.0);
    self.progress = MIN(MAX(offset/self.frame.size.height, 0.0), 1.0);
    if (!self.isRefreshing) {
        [self redrawFromProgress:self.progress];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (!self.isRefreshing && self.progress >= 1.0) {
        if ([self.delegate respondsToSelector:@selector(refreshViewDidRefresh:)]) {
            [self.delegate refreshViewDidRefresh:self];
        }
        [self beginRefreshing];
    }
}

- (void)beginRefreshing
{
    self.isRefreshing = YES;

    
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets insets = self.scrollView.contentInset;
        insets.top += self.frame.size.height;
        self.scrollView.contentInset = insets;
    }];
    
    CABasicAnimation *startAnim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnim.fromValue = @(-0.5);
    startAnim.toValue = @(1.0);
    
    CABasicAnimation *endAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnim.fromValue = @(0.0);
    endAnim.toValue = @(1.0);
    
    CAAnimationGroup *strokeGroup = [[CAAnimationGroup alloc] init];
    strokeGroup.duration = 1.5;
    strokeGroup.repeatCount = 5;
    strokeGroup.animations = @[startAnim,endAnim];
    [self.ovalShapeLayer addAnimation:strokeGroup forKey:nil];
    
    CAKeyframeAnimation *airFrameAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    airFrameAnim.path = self.ovalShapeLayer.path;
    airFrameAnim.calculationMode = kCAAnimationPaced;
    
    CABasicAnimation *rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnim.fromValue = @(0);
    rotationAnim.toValue = @(2 * M_PI);
    
    CAAnimationGroup *airGroup = [[CAAnimationGroup alloc] init];
    airGroup.duration = 1.5;
    airGroup.repeatCount = 5.0;
    airGroup.animations = @[airFrameAnim,rotationAnim];
    [self.airplaneLayer addAnimation:airGroup forKey:nil];
}

- (void)endRefresh
{
    self.isRefreshing = NO;
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        UIEdgeInsets insets = self.scrollView.contentInset;
        insets.top -= self.frame.size.height;
        self.scrollView.contentInset = insets;
    } completion:^(BOOL finished) {
        [self.ovalShapeLayer removeAllAnimations];
        [self.airplaneLayer removeAllAnimations];
    }];
}

- (void)redrawFromProgress:(CGFloat)progress
{
    self.ovalShapeLayer.strokeEnd = progress;
    self.airplaneLayer.opacity = progress;
}

@end
