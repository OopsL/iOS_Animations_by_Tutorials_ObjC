//
//  GalleryViewController.m
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import "GalleryViewController.h"
#import "ImageViewCard.h"

@interface GalleryViewController ()

@property(nonatomic, strong) NSArray *imagesArray;

@property(nonatomic, assign) Boolean isOpen;

@end

@implementation GalleryViewController

- (NSArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = @[
                         [[ImageViewCard alloc] initWithImageName:@"Hurricane_Katia.jpg" title:@"Hurricane Katia"],
                         [[ImageViewCard alloc] initWithImageName:@"Hurricane_Douglas.jpg" title:@"Hurricane Douglas"],
                         [[ImageViewCard alloc] initWithImageName:@"Hurricane_Norbert.jpg" title:@"Hurricane Norbert"],
                         [[ImageViewCard alloc] initWithImageName:@"Hurricane_Irene.jpg" title:@"Hurricane Irene"]
                         ];
    }
    return _imagesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"info" style:UIBarButtonItemStyleDone target:self action:@selector(info:)];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    for (ImageViewCard *image in self.imagesArray) {
        image.layer.anchorPoint = CGPointMake(0.5, 0.0);
        image.frame = self.view.bounds;
        [self.view addSubview:image];
        
        image.selectImageBlock = ^(ImageViewCard *imageCard){
            
            self.isOpen = NO;
            
            for (UIView *subView in self.view.subviews) {
                if ([subView isKindOfClass:[ImageViewCard class]]) {
                    if (subView == imageCard) {
                        [UIView animateWithDuration:0.33 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                            subView.layer.transform = CATransform3DIdentity;
                        } completion:^(BOOL finished) {
                            [self.view bringSubviewToFront:subView];
                        }];
                    }else{
                        
                        [UIView animateWithDuration:0.33 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                            subView.alpha = 0.0;
                        } completion:^(BOOL finished) {
                            
                            subView.alpha = 1.0;
                            subView.layer.transform = CATransform3DIdentity;
                        }];
                    }
          
                    
                }
            }
        };
    }
    
    self.navigationItem.title = ((ImageViewCard *)[self.imagesArray lastObject]).title;
    
    
    CATransform3D persTransform = CATransform3DIdentity;
    persTransform.m34 = -1.0/250.0;
    self.view.layer.sublayerTransform = persTransform;
}

- (void)info:(UIBarButtonItem *)leftItem
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"Info" message:@"Public Domain images by NASA" preferredStyle:UIAlertControllerStyleAlert];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertVc animated:YES completion:nil];
}
- (IBAction)toggleGallery:(UIBarButtonItem *)sender {
    if (self.isOpen) {
        
        for (UIView *subView in self.view.subviews) {
            if ([subView isKindOfClass:[ImageViewCard class]]) {
                [UIView animateWithDuration:0.33 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    subView.layer.transform = CATransform3DIdentity;
                } completion:^(BOOL finished) {
                    self.isOpen = NO;
                }];
            }
        }
    }else{
        self.isOpen = YES;
        
        CGFloat imageOffset = 50.0;
        for (UIView *subView in self.view.subviews) {
            if ([subView isKindOfClass:[ImageViewCard class]]) {
                CATransform3D transform3D = CATransform3DIdentity;
                transform3D = CATransform3DTranslate(transform3D, 0.0, imageOffset, 0.0);
                
                transform3D = CATransform3DScale(transform3D, 0.95, 0.6, 1.0);
                transform3D = CATransform3DRotate(transform3D, M_PI_4 * 0.5, -1.0, 0, 0);
                
                
                CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
                anim.fromValue = [NSValue valueWithCATransform3D:subView.layer.transform];
                anim.toValue = [NSValue valueWithCATransform3D:transform3D];
                anim.duration = 0.33;
                [subView.layer addAnimation:anim forKey:nil];
                subView.layer.transform = transform3D;
                
                imageOffset += self.view.frame.size.height / self.imagesArray.count;
            }
        }
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
