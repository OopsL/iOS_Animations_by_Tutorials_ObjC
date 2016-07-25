//
//  DetailViewController.m
//  iOS_Animations_by_Tutorials_ObjC
//
//  Created by wukai on 16/7/24.
//  Copyright © 2016年 JD.K. All rights reserved.
//

#import "DetailViewController.h"
#import "UIColor+Extension.h"
#import "ContainerViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *centerImageView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.clipsToBounds = YES;
    HamburgerView *hamburger = [[HamburgerView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.hamburger = hamburger;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:hamburger];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hamburgerViewTapped:)];
    [hamburger addGestureRecognizer:tap];
    
}


- (void)hamburgerViewTapped:(UITapGestureRecognizer *)tap
{
     ContainerViewController *containerVc = (ContainerViewController *)self.navigationController.parentViewController;
    [containerVc hideOrShowMenu:!containerVc.showingMenu animated:YES];
}

- (void)setMenuItem:(NSDictionary *)menuItem
{
    _menuItem = menuItem;
    self.centerImageView.image = [UIImage imageNamed:menuItem[@"bigImage"]];
    self.view.backgroundColor = [UIColor colorWithArray:menuItem[@"colors"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
