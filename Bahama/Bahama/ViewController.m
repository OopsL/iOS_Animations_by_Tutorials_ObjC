//
//  ViewController.m
//  Bahama


#import "ViewController.h"
#import "UIView+Extension.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *cloud1;
@property (weak, nonatomic) IBOutlet UIImageView *cloud4;
@property (weak, nonatomic) IBOutlet UIImageView *cloud2;
@property (weak, nonatomic) IBOutlet UIImageView *cloud3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnRight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.masksToBounds = YES;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.titleLabel.centerX -= self.view.bounds.size.width;
    self.userName.centerX -= self.view.bounds.size.width;
    self.passWord.centerX -= self.view.bounds.size.width;
    self.loginBtn.centerY += 30;
    self.loginBtn.alpha = 0.0;


    self.cloud1.alpha = 0.0;
    self.cloud2.alpha = 0.0;
    self.cloud3.alpha = 0.0;
    self.cloud4.alpha = 0.0;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.titleLabel.centerX += self.view.bounds.size.width;
    }];
    [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.userName.centerX += self.view.bounds.size.width;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.passWord.centerX += self.view.bounds.size.width;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.cloud1.alpha = 1.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{
       self.cloud2.alpha = 1.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.9 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.cloud3.alpha = 1.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:1.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.cloud4.alpha = 1.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:0 animations:^{
        self.loginBtn.centerY -= 30.0;
        self.loginBtn.alpha = 1.0;
    } completion:nil];

}
- (IBAction)login:(UIButton *)sender {
    
//    self.btnLeft.constant -= 40;
//    self.btnRight.constant -= 40;
//    [self.loginBtn setNeedsUpdateConstraints];
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0.0 options:0 animations:^{
        CGRect bounds = self.loginBtn.bounds;
        bounds.size.width += 80;
        self.loginBtn.bounds = bounds;
//        [self.loginBtn layoutIfNeeded];
    } completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
