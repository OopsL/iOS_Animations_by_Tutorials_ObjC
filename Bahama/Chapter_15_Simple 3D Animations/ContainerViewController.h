//
//  ContainerViewController.h
//  iOS_Animations_by_Tutorials_ObjC
//
//  Created by JD.K on 16/7/21.
//  Copyright © 2016年 JD.K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerViewController : UIViewController

@property(nonatomic, strong) NSDictionary *menuItem;

@property(nonatomic, assign) Boolean showingMenu;

- (void)hideOrShowMenu:(BOOL)show animated:(BOOL)animated;

@end
