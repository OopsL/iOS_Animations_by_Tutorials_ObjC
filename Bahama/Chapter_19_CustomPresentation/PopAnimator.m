//
//  PopAnimator.m
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import "PopAnimator.h"
#import "HerbDetailsViewController.h"

#define animDuration 1.0

@interface PopAnimator()

@end

@implementation PopAnimator

- (instancetype)init
{
    if (self = [super init]) {
        self.presenting = YES;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return animDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
   
    UIView *herbView = self.presenting? toView : [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    CGRect initialFrame = self.presenting? self.originFrame : herbView.frame;
    CGRect finalFrame = self.presenting? herbView.frame : self.originFrame;
    
    CGFloat xScaleFactor = self.presenting? initialFrame.size.width / finalFrame.size.width : finalFrame.size.width / initialFrame.size.width;
    CGFloat yScaleFactor = self.presenting? initialFrame.size.height / finalFrame.size.width : finalFrame.size.height / initialFrame.size.height;
    
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
    if (self.presenting) {
        herbView.transform = scaleTransform;
        herbView.center = CGPointMake(CGRectGetMidX(initialFrame), CGRectGetMidY(initialFrame));
        herbView.clipsToBounds = YES;
    }
    
     [containerView addSubview:toView];
    [containerView bringSubviewToFront:herbView];
    
    HerbDetailsViewController *herbVc = [transitionContext viewControllerForKey:self.presenting? UITransitionContextToViewControllerKey : UITransitionContextFromViewControllerKey];
    
    herbVc.containerView.alpha = 0.0;
    
    [UIView animateWithDuration:animDuration delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:0 animations:^{
        herbView.transform = self.presenting? CGAffineTransformIdentity : scaleTransform;
        herbView.center = CGPointMake(CGRectGetMidX(finalFrame), CGRectGetMidY(finalFrame));
        herbVc.containerView.alpha = self.presenting? 1.0 : 0.0;
    } completion:^(BOOL finished) {
        
        if (!self.presenting) {
            if (self.dismissCompletion) {
                self.dismissCompletion();
            }
        }
        
        [transitionContext completeTransition:YES];
    }];
    
    CABasicAnimation *cornerAnim = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerAnim.fromValue = self.presenting? @(0.0) : @(20.0/xScaleFactor);
    cornerAnim.toValue = self.presenting? @(0.0) : @(20.0/xScaleFactor);
    cornerAnim.duration = animDuration/2;
    [herbView.layer addAnimation:cornerAnim forKey:nil];
    herbView.layer.cornerRadius = self.presenting? 0.0:20.0/xScaleFactor;
}

@end
