//
//  AvatarView.h
//  iOS_Animations_by_Tutorials_ObjC
//
//  Created by wukai on 16/7/16.
//  Copyright © 2016年 JD.K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvatarView : UIView

@property(nonatomic, strong) IBInspectable UIImage *avatarImage;

@property(nonatomic, copy) IBInspectable NSString *name;

@end
