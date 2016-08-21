//
//  MasterViewController.h
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import <UIKit/UIKit.h>
#import "RWLogoLayer.h"
@class RevealAnimator;

@interface MasterViewController : UIViewController

@property(nonatomic, weak) CAShapeLayer *logo;

@property(nonatomic, strong) RevealAnimator *transition;

@end
