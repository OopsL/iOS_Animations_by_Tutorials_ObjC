//
//  PopAnimator.h
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import <UIKit/UIKit.h>

typedef void(^dismissCompletion)();

@interface PopAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign) BOOL presenting;
@property(nonatomic, assign) CGRect originFrame;
@property(nonatomic, copy) dismissCompletion dismissCompletion;

@end
