//
//  HamburgerView.m
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import "HamburgerView.h"

@interface HamburgerView()

@property(nonatomic, weak) UIImageView *iv;

@end

@implementation HamburgerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self config];
    }
    return self;
}

- (void)config
{
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Hamburger"]];
    iv.contentMode = UIViewContentModeCenter;
    self.iv = iv;
    [self addSubview:iv];
}

- (void)rotate:(CGFloat)percent
{
//    CGFloat angle = percent * M_PI_2;
//    self.iv.transform = CGAffineTransformMakeRotation(angle);
    
    CATransform3D identity = CATransform3DIdentity;
    identity.m34 = -1.0/1000.0;
    CGFloat angle = percent * -M_PI;
    self.iv.layer.transform = CATransform3DRotate(identity, angle, 1.0, 1.0, 0);
    
}

@end
