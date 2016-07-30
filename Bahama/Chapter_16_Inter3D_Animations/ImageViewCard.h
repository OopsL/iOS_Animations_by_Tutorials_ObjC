//
//  ImageViewCard.h
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import <UIKit/UIKit.h>
@class ImageViewCard;

typedef void(^selectImageBlock)(ImageViewCard *);

@interface ImageViewCard : UIImageView


@property(nonatomic, copy) NSString *title;

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title;

@property(nonatomic, copy) selectImageBlock selectImageBlock;

@end
