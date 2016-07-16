//
//  ViewController.m
//  Chapter8_Layer
//
//

#import "ViewController.h"
#import "UIView+Extension.h"

@interface ViewController ()<UITextFieldDelegate>
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
@property(nonatomic, weak) UILabel *flyInfo;
@property(nonatomic, weak) CALayer *balloon;
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
    
    self.loginBtn.layer.cornerRadius = 8.0;
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
    
    UILabel *flyInfo = [[UILabel alloc] initWithFrame:CGRectMake(0.0, self.loginBtn.centerY + 60, self.view.bounds.size.width, 30)];
    flyInfo.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    flyInfo.backgroundColor = [UIColor clearColor];
    flyInfo.textAlignment = NSTextAlignmentCenter;
    flyInfo.textColor = [UIColor whiteColor];
    flyInfo.text = @"Tap on a field and enter username and password";
    self.flyInfo = flyInfo;
    [self.view insertSubview:flyInfo belowSubview:self.loginBtn];
    
    self.userName.delegate = self;
    self.password.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CABasicAnimation *cloudAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    cloudAnim.fromValue = @(0.0);
    cloudAnim.toValue = @(1.0);
    cloudAnim.duration = 0.5;
    cloudAnim.fillMode = kCAFillModeBackwards;
    cloudAnim.beginTime = CACurrentMediaTime() + 0.5;
    [self.cloud1.layer addAnimation:cloudAnim forKey:nil];
    
    cloudAnim.beginTime = CACurrentMediaTime() + 0.7;
    [self.cloud2.layer addAnimation:cloudAnim forKey:nil];
    
    cloudAnim.beginTime = CACurrentMediaTime() + 0.9;
    [self.cloud3.layer addAnimation:cloudAnim forKey:nil];
    
    cloudAnim.beginTime = CACurrentMediaTime() + 1.1;
    [self.cloud4.layer addAnimation:cloudAnim forKey:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CAAnimationGroup *formGroup = [[CAAnimationGroup alloc] init];
    formGroup.duration = 0.5;
    formGroup.fillMode = kCAFillModeBackwards;
    
    CABasicAnimation *flyRight = [CABasicAnimation animationWithKeyPath:@"position.x"];
    flyRight.fromValue = @(-self.view.bounds.size.width * 0.5);
    flyRight.toValue = @(self.view.bounds.size.width * 0.5);
    
    CABasicAnimation *fadeFormIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeFormIn.fromValue = @(0.25);
    fadeFormIn.toValue = @(1.0);
    
    formGroup.animations = @[flyRight,fadeFormIn];
    [self.titleLabel.layer addAnimation:formGroup forKey:nil];
    
    formGroup.delegate = self;
    [formGroup setValue:@"form" forKey:@"name"];
    
    formGroup.beginTime = CACurrentMediaTime() + 0.3;
    [formGroup setValue:self.userName.layer forKey:@"layer"];
    [self.userName.layer addAnimation:formGroup forKey:nil];
    
    formGroup.beginTime = CACurrentMediaTime() + 0.4;
    [formGroup setValue:self.password.layer forKey:@"layer"];
    [self.password.layer addAnimation:formGroup forKey:nil];

    [self animateCloud:_cloud1.layer];
    [self animateCloud:_cloud2.layer];
    [self animateCloud:_cloud3.layer];
    [self animateCloud:_cloud4.layer];
    
    CABasicAnimation *flyLeft = [CABasicAnimation animationWithKeyPath:@"position.x"];
    flyLeft.fromValue = @(self.flyInfo.layer.position.x + self.view.bounds.size.width);
    flyLeft.toValue = @(self.flyInfo.layer.position.x);
//    flyLeft.fillMode = kCAFillModeBackwards;
    flyLeft.duration = 5.0;
//    flyLeft.repeatCount = 2.5;
//    flyLeft.autoreverses = YES;
//    flyLeft.repeatDuration = 10;
//    flyLeft.speed = 2.0;
//    self.flyInfo.layer.speed = 2.0;
//    self.view.layer.speed = 2.0;
    [self.flyInfo.layer addAnimation:flyLeft forKey:@"infoAppear"];
    
    
    CABasicAnimation *fadeLabelIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeLabelIn.fromValue = @(0.2);
    fadeLabelIn.toValue = @(1.0);
    fadeLabelIn.duration = 2.5;
    [self.flyInfo.layer addAnimation:fadeLabelIn forKey:@"fadeIn"];
    
    
    CAAnimationGroup *groupAnim = [[CAAnimationGroup alloc] init];
    groupAnim.beginTime = CACurrentMediaTime() + 0.5;
    groupAnim.duration = 0.5;
    groupAnim.fillMode = kCAFillModeBackwards;
    groupAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *scaleDown = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleDown.fromValue = @(3.5);
    scaleDown.toValue = @(1.0);
    
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotate.fromValue = @(M_PI_4);
    rotate.toValue = @(0.0);
    
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.fromValue = @(0.0);
    opacity.toValue = @(1.0);
    
    groupAnim.animations = @[scaleDown,rotate,opacity];
    
    [self.loginBtn.layer addAnimation:groupAnim forKey:nil];
}

- (void)animateCloud:(CALayer *)layer
{
    CGFloat duration = (self.view.frame.size.width - layer.frame.origin.x)*60/self.view.frame.size.width;
    CABasicAnimation *cloudAnim = [CABasicAnimation animationWithKeyPath:@"position.x"];
    cloudAnim.toValue = @(self.view.frame.size.width + layer.frame.size.width * 0.5);
    cloudAnim.duration = duration;
    [cloudAnim setValue:@"cloud" forKey:@"name"];
    [cloudAnim setValue:layer forKey:@"layer"];
    cloudAnim.delegate = self;
    [layer addAnimation:cloudAnim forKey:nil];
}

- (IBAction)login:(UIButton *)sender {
    
    [UIView animateWithDuration:1.5 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:0.0 options:0 animations:^{
        self.loginBtn.width += 80.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.33 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:0 animations:^{
        self.loginBtn.centerY += 60.0;
//        self.loginBtn.backgroundColor = [UIColor colorWithRed:0.85 green:0.83 blue:0.45 alpha:1.0];
        [self tintBackgroundColor:self.loginBtn.layer backgroundColor:[UIColor colorWithRed:0.85 green:0.83 blue:0.45 alpha:1.0]];
        self.indicator.alpha = 1.0;
        self.indicator.center = CGPointMake(40, self.loginBtn.frame.size.height * 0.5);
    } completion:^(BOOL finished) {
        [self showMessage:0];
    }];
    
    [self cornerRadius:self.loginBtn.layer radius:self.loginBtn.height * 0.5];
    
    CALayer *balloon = [CALayer layer];
    balloon.contents = (id)[UIImage imageNamed:@"balloon"].CGImage;
    balloon.frame = CGRectMake(-50, 0, 50, 65);
    self.balloon = balloon;
    [self.view.layer insertSublayer:balloon below:self.userName.layer];
    
    CAKeyframeAnimation *flight = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    flight.duration = 12;
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(-50, 0)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width + 50, 160)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(-50, self.loginBtn.centerY)];
    flight.values = @[value1,value2,value3];
    flight.keyTimes = @[@(0.0),@(0.5),@(1.0)];
    [balloon addAnimation:flight forKey:nil];
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
    CAKeyframeAnimation *wobble = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    wobble.duration = 0.25;
    wobble.values = @[@(0),@(-M_PI_4),@(0),@(M_PI_4),@(0)];
    wobble.keyTimes = @[@(0.0),@(0.25),@(0.5),@(0.75),@(1.0)];
    wobble.repeatCount = 4;
    [self.titleLabel.layer addAnimation:wobble forKey:nil];
    
    [UIView transitionWithView:self.status duration:0.2 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        self.status.hidden = YES;
        self.status.center = self.btnCenter;
    } completion:nil];
    
    [UIView animateWithDuration:0.2 delay:0.0 options:0 animations:^{
        self.indicator.center = CGPointMake(-25, 16);
        self.indicator.alpha = 0.0;
//        self.loginBtn.backgroundColor = [UIColor colorWithRed:0.63 green:0.84 blue:0.35 alpha:1.0];
        [self tintBackgroundColor:self.loginBtn.layer backgroundColor:[UIColor colorWithRed:0.63 green:0.84 blue:0.35 alpha:1.0]];
        
        [self cornerRadius:self.loginBtn.layer radius:8.0];
        self.loginBtn.width -= 80.0;
        self.loginBtn.centerY -= 60.0;
    } completion:nil];
   
}


- (void)tintBackgroundColor:(CALayer *)layer backgroundColor:(UIColor *)color
{
    CABasicAnimation *colorAnim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    colorAnim.fromValue = (__bridge id _Nullable)(layer.backgroundColor);
    colorAnim.toValue = (__bridge id _Nullable)(color.CGColor);
    colorAnim.duration = 1.0;
    [layer addAnimation:colorAnim forKey:nil];
    
    layer.backgroundColor = color.CGColor;
}

- (void)cornerRadius:(CALayer *)layer radius:(CGFloat)radius
{
    CABasicAnimation *cornerRadiusAnim = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerRadiusAnim.fromValue = @(layer.cornerRadius);
    cornerRadiusAnim.toValue = @(radius);
    cornerRadiusAnim.duration = 0.33;
    [layer addAnimation:cornerRadiusAnim forKey:nil];
    
    layer.cornerRadius = radius;
}

- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString *name = [anim valueForKey:@"name"];
     CALayer *layer = [anim valueForKey:@"layer"];
    if (name.length && [name isEqualToString:@"form"]) {
        if (layer) {
            [anim setValue:nil forKey:@"layer"];
            CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnim.fromValue = @(1.25);
            scaleAnim.toValue = @(1.0);
            scaleAnim.duration = 0.25;
            [layer addAnimation:scaleAnim forKey:nil];
        }
    }else if (name.length && [name isEqualToString:@"cloud"]){
        CGPoint position = layer.position;
        position.x = -layer.frame.size.width * 0.5;
        layer.position = position;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self animateCloud:layer];
        });
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.flyInfo.layer removeAnimationForKey:@"infoAppear"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
