//
//  RevealAnimator.h
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import <UIKit/UIKit.h>

@interface RevealAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign) UINavigationControllerOperation operation;

@end
