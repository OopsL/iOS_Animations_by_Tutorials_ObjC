//
//  ImageViewCard.h
//  iOS_Animations_by_Tutorials_ObjC
//
//  Created by JD.K on 16/7/27.
//  Copyright © 2016年 JD.K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewCard : UIImageView


@property(nonatomic, copy) NSString *title;

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title;

@end
