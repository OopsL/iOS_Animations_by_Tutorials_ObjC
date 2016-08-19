//
//  RevealAnimator.m
//  iOS_Animations_by_Tutorials_ObjC
//

#import "RevealAnimator.h"
#import "MasterViewController.h"
#import "DetTableViewController.h"

#define animDuration 2.0

@interface RevealAnimator()

@property(nonatomic, weak) id <UIViewControllerContextTransitioning> storeContext;

@end

@implementation RevealAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return animDuration;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.storeContext = transitionContext;
   
    if (self.operation == UINavigationControllerOperationPush) {
    
            MasterViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
            DetTableViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
            [[transitionContext containerView] addSubview:toVc.view];
            
            CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
            anim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
            anim.toValue = [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeTranslation(0, -15, 0), CATransform3DMakeScale(150, 150, 1.0))];
            anim.duration = animDuration;
            anim.fillMode = kCAFillModeForwards;
            anim.delegate = self;
            anim.removedOnCompletion = false;
            anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            [toVc.maskLayer addAnimation:anim forKey:nil];
            [fromVc.logo addAnimation:anim forKey:nil];
        
        CABasicAnimation *opaqueAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opaqueAnim.duration = animDuration;
        opaqueAnim.fromValue = @(0.0);
        opaqueAnim.toValue = @(1.0);
        [toVc.view.layer addAnimation:opaqueAnim forKey:nil];
        
    }else{
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        [[transitionContext containerView] insertSubview:toView belowSubview:fromView];
        [UIView animateWithDuration:animDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            fromView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.storeContext) {
        
        MasterViewController *fromVc = [self.storeContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        [fromVc.logo removeAllAnimations];
        //最后调用完成方法
        [self.storeContext completeTransition:![self.storeContext transitionWasCancelled]];

    }
    self.storeContext = nil;
}

@end
