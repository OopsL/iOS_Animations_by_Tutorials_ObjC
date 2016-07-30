//
//  ContainerViewController.h
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import <UIKit/UIKit.h>

@interface ContainerViewController : UIViewController

@property(nonatomic, strong) NSDictionary *menuItem;

@property(nonatomic, assign) Boolean showingMenu;

- (void)hideOrShowMenu:(BOOL)show animated:(BOOL)animated;

@end
