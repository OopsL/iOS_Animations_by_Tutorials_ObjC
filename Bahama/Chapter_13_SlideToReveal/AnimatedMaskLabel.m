//
//  AnimatedMaskLabel.m
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import "AnimatedMaskLabel.h"

IB_DESIGNABLE
@interface AnimatedMaskLabel()

@property(nonatomic, strong) CAGradientLayer *gradientLayer;
@property(nonatomic, strong) NSDictionary *textAttributes;

@end

@implementation AnimatedMaskLabel

- (CAGradientLayer *)gradientLayer
{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        
        _gradientLayer.startPoint = CGPointMake(0.0, 0.5);
        _gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        NSArray *colors = @[
                            (id)([UIColor yellowColor].CGColor),
                            (id)([UIColor greenColor].CGColor),
                            (id)([UIColor orangeColor].CGColor),
                            (id)([UIColor cyanColor].CGColor),
                            (id)([UIColor redColor].CGColor),
                            (id)([UIColor yellowColor].CGColor)
                            ];
        _gradientLayer.colors = colors;
        
        _gradientLayer.locations = @[@(0.0),@(0.0),@(0.0),@(0.0),@(0.0),@(0.25)];
    }
    return _gradientLayer;
}

- (NSDictionary *)textAttributes
{
    if (!_textAttributes) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;
        _textAttributes = @{
                            NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Thin" size:28],
                            NSParagraphStyleAttributeName : style
                            };
    }
    return _textAttributes;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _text = text;
    [self setNeedsDisplay];
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0);
    [text drawInRect:self.bounds withAttributes:self.textAttributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.contents = (__bridge id _Nullable)(image.CGImage);
    //gradientLayer.origin.x
    maskLayer.frame = CGRectOffset(self.bounds, self.bounds.size.width, 0);
    maskLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.gradientLayer.mask = maskLayer;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gradientLayer.frame = CGRectMake(-self.bounds.size.width, self.bounds.origin.y, self.bounds.size.width * 3, self.bounds.size.height);
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    [self.layer addSublayer:self.gradientLayer];
    
    CABasicAnimation *gradientAnim = [CABasicAnimation animationWithKeyPath:@"locations"];
    gradientAnim.fromValue = @[@(0.0),@(0.0),@(0.0),@(0.0),@(0.0),@(0.25)];
    gradientAnim.toValue = @[@(0.65),@(0.8),@(0.85),@(0.9),@(0.95),@(1.0)];
    gradientAnim.duration = 3.0;
    gradientAnim.repeatCount = MAXFLOAT;
    
    [self.gradientLayer addAnimation:gradientAnim forKey:nil];
}

@end
