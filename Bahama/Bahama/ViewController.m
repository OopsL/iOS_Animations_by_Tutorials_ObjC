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
@property(nonatomic, weak) UIActivityIndicatorView *indicatorView;
@property(nonatomic, weak) UIImageView *bannerView;
@property(nonatomic, weak) UILabel *bannerLabel;
@property(nonatomic, strong) NSArray *bannerTextArray;
@property(nonatomic, assign) CGPoint bannerViewCenter;
/**
 *  是否执行viewDidLayoutSubviews中的动画  键盘弹出时 会调用此方法.
 */
@property(nonatomic, assign) BOOL excuteLayoutAnim;

@end

@implementation ViewController

- (NSArray *)bannerTextArray
{
    if (!_bannerTextArray) {
        _bannerTextArray = [[NSArray alloc] initWithObjects:@"Connecting ...", @"Authorizing ...", @"Sending credentials ...", @"Failed", nil];
    }
    return _bannerTextArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.excuteLayoutAnim = YES;
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.masksToBounds = YES;
    
    [self initActivityIndicator];

    [self initBanner];
}

- (void)initActivityIndicator
{
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.frame = CGRectMake(-25, 6.0, 20, 20);
    [indicatorView startAnimating];
    indicatorView.alpha = 0.0;
    self.indicatorView = indicatorView;
    [self.loginBtn addSubview:indicatorView];
}

/**
 *  初始化banner
 */
- (void)initBanner
{
    UIImageView *bannerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
    
    bannerView.hidden = YES;
    self.bannerView = bannerView;
    [self.view addSubview:bannerView];
    
    UILabel *bannerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bannerView.width, bannerView.height)];
    bannerLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
    bannerLabel.textColor = [UIColor colorWithRed:0.89 green:0.38 blue:0.0 alpha:1.0];
    bannerLabel.textAlignment = NSTextAlignmentCenter;
    self.bannerLabel = bannerLabel;
    [self.bannerView addSubview:bannerLabel];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    NSLog(@"%s",__func__);
    
    if (self.excuteLayoutAnim) {
        self.bannerView.center = self.loginBtn.center;
        self.bannerViewCenter = self.bannerView.center;
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
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.excuteLayoutAnim = NO;
    
    [self animateCloud:self.cloud1];
    [self animateCloud:self.cloud2];
    [self animateCloud:self.cloud3];
    [self animateCloud:self.cloud4];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.titleLabel.centerX += self.view.bounds.size.width;
    }];
//    [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.userName.centerX += self.view.bounds.size.width;
//    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.3 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:0 animations:^{
        self.userName.centerX += self.view.bounds.size.width;
    } completion:nil];
    
//    [UIView animateWithDuration:0.5 delay:0.4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.passWord.centerX += self.view.bounds.size.width;
//    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.4 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:0 animations:^{
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
    
    [UIView animateWithDuration:0.33 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:0 animations:^{
        self.loginBtn.centerY += 60;
        self.loginBtn.backgroundColor = [UIColor colorWithRed:0.85 green:0.83 blue:0.45 alpha:1.0];
        self.indicatorView.center = CGPointMake(40, self.loginBtn.frame.size.height * 0.5);
        self.indicatorView.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        [self showBannerWithIndex:0];
    }];
    
}

- (void)showBannerWithIndex:(NSInteger)index
{
    if (index < self.bannerTextArray.count) {
        self.bannerLabel.text = self.bannerTextArray[index];
    }
//    [UIView transitionWithView:self.bannerView duration:0.33 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionCurlDown animations:^{
//        self.bannerView.hidden = NO;
//    } completion:^(BOOL finished) {
//        if (index < self.bannerTextArray.count - 1) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self removeBannerMessage:index + 1];
//            });
//        }
//    }];
    
    [UIView transitionWithView:self.bannerView duration:0.33 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        self.bannerView.hidden = NO;
    } completion:^(BOOL finished) {
        if (index < self.bannerTextArray.count - 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeBannerMessage:index + 1];
            });
        }else{
            [self resetForm];
        }
    }];
    
}

- (void)removeBannerMessage:(NSInteger)index
{
    [UIView animateWithDuration:0.33 animations:^{
        self.bannerView.centerX += self.view.width;
    } completion:^(BOOL finished) {
        self.bannerView.hidden = YES;
        self.bannerView.center = self.bannerViewCenter;
        
        [self showBannerWithIndex:index];
    }];
}

- (void)resetForm
{
    [UIView transitionWithView:self.bannerView duration:0.2 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        self.bannerView.hidden = YES;
        self.bannerView.center = self.bannerViewCenter;
    } completion:nil];
    
    [UIView animateWithDuration:0.2 delay:0.0 options:0 animations:^{
        self.indicatorView.center = CGPointMake(-25, 16);
        self.indicatorView.alpha = 0.0;
        self.loginBtn.backgroundColor = [UIColor colorWithRed:0.63 green:0.84 blue:0.35 alpha:1.0];
        //修改bounds,与之前增加width时保持一致
        CGRect bounds = self.loginBtn.bounds;
        bounds.size.width -= 80.0;
        self.loginBtn.bounds = bounds;
        self.loginBtn.centerY -= 60;
        
        
    } completion:nil];
}

- (void)animateCloud:(UIImageView *)cloud
{
    //移动view.width设置为60s
    CGFloat duration = (self.view.frame.size.width - cloud.frame.origin.x) * 60 / self.view.frame.size.width;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        cloud.originX = self.view.frame.size.width;
    } completion:^(BOOL finished) {
        cloud.originX = -cloud.frame.size.width;
        [self animateCloud:cloud];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
