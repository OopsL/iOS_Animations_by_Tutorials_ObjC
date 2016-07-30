//
//  ImageViewCard.m
//  iOS_Animations_by_Tutorials_ObjC
//
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
    if (self.selectImageBlock) {
        self.selectImageBlock(self);
    }
}

@end
