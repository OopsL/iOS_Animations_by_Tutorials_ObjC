//
//  MasterViewController.m
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import "MasterViewController.h"
#import "RWLogoLayer.h"
#import "RevealAnimator.h"


@interface MasterViewController ()<UINavigationControllerDelegate>


@end

@implementation MasterViewController

- (RevealAnimator *)transition
{
    if (!_transition) {
        _transition = [[RevealAnimator alloc] init];
    }
    return _transition;
}

- (CAShapeLayer *)logo
{
    if (!_logo) {
        _logo = [RWLogoLayer logoLayer];
    }
    return _logo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Start";
    self.navigationController.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self.view addGestureRecognizer:pan];
    self.logo.position = CGPointMake(self.view.layer.bounds.size.width * 0.5, self.view.layer.bounds.size.height * 0.5 -30);
    self.logo.fillColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:self.logo];
}


- (void)didPan:(UIPanGestureRecognizer *)pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.transition.interactive = true;
            [self performSegueWithIdentifier:@"details" sender:nil];
            break;
        default:
            [self.transition handlePan:pan];
            break;
    }
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    self.transition.operation = operation;
    return self.transition;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    
    if (!self.transition.interactive) {
        return nil;
    }
    return self.transition;
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
