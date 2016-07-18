//
//  AvatarView.h
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import <UIKit/UIKit.h>

@interface AvatarView : UIView

@property(nonatomic, strong) IBInspectable UIImage *avatarImage;

@property(nonatomic, copy) IBInspectable NSString *name;

@property(nonatomic, assign) BOOL shouldTransitionToFinishedState;

- (void)bounceOffPoint:(CGPoint)bouncePoint morphSize:(CGSize)morphSize;

@end
