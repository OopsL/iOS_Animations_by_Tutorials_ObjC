//
//  MenuItemCell.m
//  iOS_Animations_by_Tutorials_ObjC
//
//  Created by wukai on 16/7/24.
//  Copyright © 2016年 JD.K. All rights reserved.
//

#import "MenuItemCell.h"
#import "UIColor+Extension.h"

@interface MenuItemCell()
@property (weak, nonatomic) IBOutlet UIImageView *menuImageView;
@end

@implementation MenuItemCell

- (void)configForMenuItem:(NSDictionary *)itemDIc
{
    self.menuImageView.image = [UIImage imageNamed:itemDIc[@"image"]];
    self.backgroundColor = [UIColor colorWithArray:itemDIc[@"colors"]];
}

@end
