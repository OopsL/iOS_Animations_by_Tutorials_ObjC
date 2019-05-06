//
//  ViewController.m
//  Chapter8_Layer
//
//

#import "ViewController.h"
#import "UIView+Extension.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cloud1;
@property (weak, nonatomic) IBOutlet UIImageView *cloud2;
@property (weak, nonatomic) IBOutlet UIImageView *cloud3;
@property (weak, nonatomic) IBOutlet UIImageView *cloud4;
@property(nonatomic, weak) UIActivityIndicatorView *indicator;
@property(nonatomic, assign) CGPoint btnCenter;
@property(nonatomic, weak) UIImageView *status;
@property(nonatomic, weak) UILabel *statusLabel;
@property(nonatomic, strong) NSArray *messages;
@end

@implementation ViewController

- (NSArray *)messages
{
    if (!_messages) {
        _messages = @[@"Connecting ...", @"Authorizing ...", @"Sending credentials ...", @"Failed"];
    }
    return _messages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginBtn.layer.cornerRadius = 5.0;
    self.loginBtn.layer.masksToBounds = YES;
    self.btnCenter = self.loginBtn.center;
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(-25, 6.0, 20.0, 20.0)];
    [indicator startAnimating];
    indicator.alpha = 0.0;
    [self.loginBtn addSubview:indicator];
    self.indicator = indicator;
    
    UIImageView *status = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
    status.hidden = YES;
    status.center = self.loginBtn.center;
    self.status = status;
    [self.view addSubview:status];
    
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, status.frame.size.width, status.frame.size.height)];
    statusLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
    statusLabel.textColor = [UIColor colorWithRed:0.89 green:0.38 blue:0.0 alpha:1.0];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel = statusLabel;
    [status addSubview:statusLabel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.titleLabel.centerX -= self.view.bounds.size.width;
    self.userName.centerX -= self.view.bounds.size.width;
    self.password.centerX -= self.view.bounds.size.width;
    
    self.cloud1.alpha = 0.0;
    self.cloud2.alpha = 0.0;
    self.cloud3.alpha = 0.0;
    self.cloud4.alpha = 0.0;
    
    self.loginBtn.centerY += 30.0;
    self.loginBtn.alpha = 0.0;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.titleLabel.centerX += self.view.bounds.size.width;
    }];
    
    [UIView animateWithDuration:0.5 delay:0.3 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:0 animations:^{
        self.userName.centerX += self.view.bounds.size.width;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.4 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:0 animations:^{
        self.password.centerX += self.view.bounds.size.width;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.5 options:0 animations:^{
        self.cloud1.alpha = 1.0;
    } completion:nil];
    [UIView animateWithDuration:0.5 delay:0.7 options:0 animations:^{
        self.cloud2.alpha = 1.0;
    } completion:nil];
    [UIView animateWithDuration:0.5 delay:0.9 options:0 animations:^{
        self.cloud3.alpha = 1.0;
    } completion:nil];
    [UIView animateWithDuration:0.5 delay:1.1 options:0 animations:^{
        self.cloud4.alpha = 1.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:0 animations:^{
        self.loginBtn.centerY -= 30.0;
        self.loginBtn.alpha = 1.0;
    } completion:nil];
    
    [self animateCloud:_cloud1];
    [self animateCloud:_cloud2];
    [self animateCloud:_cloud3];
    [self animateCloud:_cloud4];
}

- (void)animateCloud:(UIImageView *)cloud
{
    CGFloat duration = (self.view.frame.size.width - cloud.frame.origin.x)*60/self.view.frame.size.width;
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        cloud.originX = self.view.frame.size.width;
    } completion:^(BOOL finished) {
        cloud.originX = -cloud.frame.size.width;
        [self animateCloud:cloud];
    }];
}

- (IBAction)login:(UIButton *)sender {
    
    [UIView animateWithDuration:1.5 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:0.0 options:0 animations:^{
        self.loginBtn.width += 80.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.33 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:0 animations:^{
        self.loginBtn.centerY += 60.0;
        self.loginBtn.backgroundColor = [UIColor colorWithRed:0.85 green:0.83 blue:0.45 alpha:1.0];
        
        self.indicator.alpha = 1.0;
        self.indicator.center = CGPointMake(40, self.loginBtn.frame.size.height * 0.5);
    } completion:^(BOOL finished) {
        [self showMessage:0];
    }];
}

- (void)showMessage:(NSInteger)index
{
    self.statusLabel.text = self.messages[index];
    [UIView transitionWithView:self.status duration:0.33 options:UIViewAnimationOptionCurveEaseOut |UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        self.status.hidden = NO;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (index < self.messages.count - 1) {
                [self removeMessage:index];
            }else{
                [self resetForm];
            }
        });
    }];
}

- (void)removeMessage:(NSInteger)index
{
    [UIView animateWithDuration:0.33 delay:0.0 options:0 animations:^{
        self.status.centerX += self.view.frame.size.width;
    } completion:^(BOOL finished) {
        self.status.hidden = YES;
        self.status.center = self.btnCenter;
        
        [self showMessage:index + 1];
    }];
}

- (void)resetForm
{
    [UIView transitionWithView:self.status duration:0.2 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        self.status.hidden = YES;
        self.status.center = self.btnCenter;
    } completion:nil];
    
    [UIView animateWithDuration:0.2 delay:0.0 options:0 animations:^{
        self.indicator.center = CGPointMake(-25, 16);
        self.indicator.alpha = 0.0;
        self.loginBtn.backgroundColor = [UIColor colorWithRed:0.63 green:0.84 blue:0.35 alpha:1.0];
        self.loginBtn.width -= 80.0;
        self.loginBtn.centerY -= 60.0;
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    // Dispose of any resources that can be recreated.
    // Dispose of any resources that can be recreated.
    // Dispose of any resources that can be recreated.

}

@end
