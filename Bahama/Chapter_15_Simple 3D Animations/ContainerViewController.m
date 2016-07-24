//
//  ContainerViewController.m
//  iOS_Animations_by_Tutorials_ObjC
//
//  Created by JD.K on 16/7/21.
//  Copyright © 2016年 JD.K. All rights reserved.
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
    [self hideOrShowMenu:false animated:false];
}

- (void)hideOrShowMenu:(BOOL)show animated:(BOOL)animated
{
    [self.scrollView setContentOffset: show ? CGPointZero:CGPointMake(self.menuContainerView.bounds.size.width, 0) animated:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailViewSegue"]) {
        UINavigationController *navi = segue.destinationViewController;
        self.detailViewController = (DetailViewController *)navi.topViewController;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    scrollView.pagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - scrollView.frame.size.width);
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
