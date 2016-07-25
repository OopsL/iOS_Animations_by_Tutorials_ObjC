//
//  DetailViewController.h
//  iOS_Animations_by_Tutorials_ObjC
//
//  Created by wukai on 16/7/24.
//  Copyright © 2016年 JD.K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HamburgerView.h"

@interface DetailViewController : UIViewController

@property(nonatomic, strong) NSDictionary *menuItem;

@property(nonatomic, weak) HamburgerView *hamburger;

@end
