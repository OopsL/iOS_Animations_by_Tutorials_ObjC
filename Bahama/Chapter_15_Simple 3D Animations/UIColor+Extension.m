//
//  UIColor+Extension.m
//  iOS_Animations_by_Tutorials_ObjC
//
//  Created by wukai on 16/7/24.
//  Copyright © 2016年 JD.K. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)colorWithArray:(NSArray *)colors
{
    if (colors.count >= 3){
        CGFloat red = [((NSNumber *)colors[0]) floatValue];
        CGFloat green = [((NSNumber *)colors[1]) floatValue];
        CGFloat blue = [((NSNumber *)colors[2]) floatValue];
        return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    }
    
    
    return nil;
}

@end
