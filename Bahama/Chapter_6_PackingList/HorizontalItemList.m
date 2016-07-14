//
//  HorizontalItemList.m
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import "HorizontalItemList.h"


#define buttonWidth 60.0
#define padding 10.0

@interface HorizontalItemList()

@end

@implementation HorizontalItemList

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.alpha = 0.0;
        for (int i=0; i<10; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"summericons_100px_0%zd",i]];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.center = CGPointMake(i * buttonWidth + 0.5 *buttonWidth, 0.5 * buttonWidth);
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            [self addSubview:imageView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapImage:)];
            [imageView addGestureRecognizer:tap];
        }
        self.contentSize = CGSizeMake(padding * buttonWidth, buttonWidth + 2*padding);
    }
    return self;
}

- (void)didTapImage:(UITapGestureRecognizer *)tap
{
    if (self.selectItem) {
        self.selectItem(tap.view.tag);
    }
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    if (self.superview == nil) return;
    
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:10.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 1.0;
        CGPoint center = self.center;
        center.x -= self.frame.size.width;;
        self.center = center;
    } completion:nil];
    
}

@end
