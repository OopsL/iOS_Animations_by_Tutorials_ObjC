//
//  ViewController.m
//  Chapter_13_SlideToReveal
//
//

#import "ViewController.h"
#import "AnimatedMaskLabel.h"
#import "UIView+Extension.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet AnimatedMaskLabel *slideView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSlide:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.slideView addGestureRecognizer:swipe];
}

- (void)didSlide:(UISwipeGestureRecognizer *)swipe
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meme"]];
    imageView.center = self.view.center;
    imageView.centerX += self.view.bounds.size.width;
    [self.view addSubview:imageView];
    
    [UIView animateWithDuration:0.33 delay:0.0 options:0 animations:^{
        self.time.centerY -= 200;
        self.slideView.centerY += 200;
        imageView.centerX -= self.view.bounds.size.width;
    } completion:nil];
    
    [UIView animateWithDuration:0.33 delay:1.0 options:0 animations:^{
        self.time.centerY += 200;
        self.slideView.centerY -= 200;
        imageView.centerX += self.view.bounds.size.width;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
