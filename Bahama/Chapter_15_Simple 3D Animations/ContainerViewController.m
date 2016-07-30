//
//  ContainerViewController.m
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import "ContainerViewController.h"
#import "DetailViewController.h"

@interface ContainerViewController ()<UIScrollViewDelegate>

@property(nonatomic, weak) DetailViewController *detailViewController;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *menuContainerView;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setMenuItem:(NSDictionary *)menuItem
{
    _menuItem = menuItem;
    self.detailViewController.menuItem = menuItem;
    [self hideOrShowMenu:false animated:true];
}

- (void)hideOrShowMenu:(BOOL)show animated:(BOOL)animated
{
    self.showingMenu = show;
    [self.scrollView setContentOffset: show ? CGPointZero:CGPointMake(self.menuContainerView.bounds.size.width, 0) animated:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.menuContainerView.layer.anchorPoint = CGPointMake(1.0, 0.5);
    [self hideOrShowMenu:_showingMenu animated:false];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailViewSegue"]) {
        UINavigationController *navi = segue.destinationViewController;
        self.detailViewController = (DetailViewController *)navi.topViewController;
    }
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"%s",__func__);
    self.menuContainerView.layer.shouldRasterize = true;
    self.menuContainerView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{NSLog(@"%s",__func__);
    CGFloat percent = scrollView.contentOffset.x / self.menuContainerView.bounds.size.width;
    self.menuContainerView.layer.transform = [self transformForPercent:percent];
    self.menuContainerView.alpha = 1.0 - percent;
    
    [self.detailViewController.hamburger rotate:1.0 - percent];
    
    scrollView.pagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - scrollView.frame.size.width);
    self.showingMenu = !CGPointEqualToPoint(CGPointMake(self.menuContainerView.bounds.size.width, 0), self.scrollView.contentOffset);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.menuContainerView.layer.shouldRasterize = false;
}

- (CATransform3D)transformForPercent:(CGFloat)percent
{
   CATransform3D identity = CATransform3DIdentity;
    identity.m34 = -1.0/1000.0;
    CGFloat angle = percent * -M_PI_2;
    CGFloat offsetX = CGRectGetWidth(self.menuContainerView.bounds) * 0.5;
    CATransform3D rotation = CATransform3DRotate(identity,angle, 0, 1.0, 0);
    CATransform3D translate = CATransform3DMakeTranslation(offsetX, 0, 0);
    return CATransform3DConcat(rotation, translate);
//    return rotation;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
