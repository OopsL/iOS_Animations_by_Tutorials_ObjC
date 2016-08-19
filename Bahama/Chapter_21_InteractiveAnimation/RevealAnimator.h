//
//  RevealAnimator.h
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import <UIKit/UIKit.h>

@interface RevealAnimator : UIPercentDrivenInteractiveTransition<UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign) UINavigationControllerOperation operation;

@property(nonatomic, assign) BOOL interactive;

- (void)handlePan:(UIPanGestureRecognizer *)pan;

@end
