//
//  AvatarView.m
//  iOS_Animations_by_Tutorials_ObjC
//
//  Created by wukai on 16/7/16.
//  Copyright © 2016年 JD.K. All rights reserved.
//

#import "AvatarView.h"

#define customLineWidth 6.0
#define nimationDuration 1.0

IB_DESIGNABLE
@interface AvatarView()

@property(nonatomic, weak) CALayer *photoLayer;
@property(nonatomic, weak) CAShapeLayer *circleLayer;
@property(nonatomic, weak) CAShapeLayer *maskLayer;
@property(nonatomic, weak) UILabel *label;

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

@end
