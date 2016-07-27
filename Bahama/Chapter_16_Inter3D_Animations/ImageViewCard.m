//
//  ImageViewCard.m
//  iOS_Animations_by_Tutorials_ObjC
//
//  Created by JD.K on 16/7/27.
//  Copyright © 2016年 JD.K. All rights reserved.
//

#import "ImageViewCard.h"

@interface ImageViewCard()


@end

@implementation ImageViewCard

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title
{
    if (self = [super initWithImage:[UIImage imageNamed:imageName]]) {
        
        self.title = title;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapHandler:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)didTapHandler:(UITapGestureRecognizer *)tap
{
    
}

@end
