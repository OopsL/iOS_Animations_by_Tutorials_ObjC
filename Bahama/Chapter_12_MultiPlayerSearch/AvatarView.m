//
//  AvatarView.m
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import "AvatarView.h"

#define customLineWidth 6.0
#define animationDuration 1.0

IB_DESIGNABLE
@interface AvatarView()

@property(nonatomic, weak) CALayer *photoLayer;
@property(nonatomic, weak) CAShapeLayer *circleLayer;
@property(nonatomic, weak) CAShapeLayer *maskLayer;
@property(nonatomic, weak) UILabel *label;
@property(nonatomic, assign) BOOL isSquare;

@end

@implementation AvatarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupLayer];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupLayer];
    }
    return self;
}

- (void)setupLayer
{
    CALayer *photoLayer = [CALayer layer];
    self.photoLayer = photoLayer;
    [self.layer addSublayer:photoLayer];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    self.circleLayer = circleLayer;
    [self.layer addSublayer:circleLayer];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    self.maskLayer = maskLayer;
    photoLayer.mask = maskLayer;
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    self.label = label;
    [self addSubview:label];
}

- (void)setAvatarImage:(UIImage *)image
{
    _avatarImage = image;
    self.photoLayer.contents = (__bridge id _Nullable)(image.CGImage);
}

- (void)setName:(NSString *)name
{
    _name = name;
    self.label.text = name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.photoLayer.frame = CGRectMake((self.bounds.size.width - self.avatarImage.size.width + customLineWidth) * 0.5, (self.bounds.size.width - self.avatarImage.size.width - customLineWidth) * 0.5, self.avatarImage.size.width, self.avatarImage.size.height);
    self.circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
    self.circleLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.circleLayer.lineWidth = customLineWidth;
    self.circleLayer.fillColor = [UIColor clearColor].CGColor;
    
    self.maskLayer.path = self.circleLayer.path;
    self.maskLayer.position = CGPointMake(0.0, 10.0);
    
    self.label.frame = CGRectMake(0, self.bounds.size.height + 10, self.bounds.size.width, 24);
    
}

- (void)bounceOffPoint:(CGPoint)bouncePoint morphSize:(CGSize)morphSize
{
    CGPoint orignCenter = self.center;
    [UIView animateWithDuration:animationDuration delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.0 options:0 animations:^{
        self.center = bouncePoint;
    } completion:^(BOOL finished) {
        if (self.shouldTransitionToFinishedState) {
            [self animateToSquare];
        }
    }];
    
    [UIView animateWithDuration:animationDuration delay:animationDuration usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:0 animations:^{
        self.center = orignCenter;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!self.isSquare)
            [self bounceOffPoint:bouncePoint morphSize:morphSize];
        });
    }];
    
    CGRect leftMorphFrame = CGRectMake(self.bounds.size.width - morphSize.width, self.bounds.size.height - morphSize.height, morphSize.width, morphSize.height);
    
    CGRect rightMorphFrame = CGRectMake(0.0, self.bounds.size.height - morphSize.height, morphSize.width, morphSize.height);
    
    CGRect morphFrame = orignCenter.x < bouncePoint.x ? leftMorphFrame : rightMorphFrame;
    //形变
    CABasicAnimation *morphAnim = [CABasicAnimation animationWithKeyPath:@"path"];
    morphAnim.duration = animationDuration;
    morphAnim.toValue = (__bridge id _Nullable)([UIBezierPath bezierPathWithOvalInRect:morphFrame].CGPath);
    morphAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.circleLayer addAnimation:morphAnim forKey:nil];
    [self.maskLayer addAnimation:morphAnim forKey:nil];

}

- (void)animateToSquare
{
    self.isSquare = YES;
    
    UIBezierPath *squarePath = [UIBezierPath bezierPathWithRect:self.bounds];
    CABasicAnimation *squareAnim = [CABasicAnimation animationWithKeyPath:@"path"];
    squareAnim.fromValue = (__bridge id _Nullable)(self.circleLayer.path);
    squareAnim.toValue = (__bridge id _Nullable)(squarePath.CGPath);
    squareAnim.duration = 0.25;
    
    [self.circleLayer addAnimation:squareAnim forKey:nil];
    [self.maskLayer addAnimation:squareAnim forKey:nil];
    
    self.circleLayer.path = squarePath.CGPath;
    self.maskLayer.path = squarePath.CGPath;
}

@end
