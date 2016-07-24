//
//  MenuViewController.m
//  iOS_Animations_by_Tutorials_ObjC
//
//  Created by wukai on 16/7/24.
//  Copyright © 2016年 JD.K. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuItemCell.h"
#import "ContainerViewController.h"

@interface MenuViewController ()

@property(nonatomic, strong) NSArray *menuItems;

@end

@implementation MenuViewController

- (NSArray *)menuItems
{
    if (!_menuItems) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MenuItems" ofType:@"plist"];
        _menuItems =[NSArray arrayWithContentsOfFile:path];
    }
    return  _menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.clipsToBounds = YES;
    ContainerViewController *containerVc = (ContainerViewController *)self.navigationController.parentViewController;
    containerVc.menuItem = self.menuItems[0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.menuItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MAX(80, CGRectGetHeight(self.view.bounds) / self.menuItems.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat
{
    MenuItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuItemCell"];
    [cell configForMenuItem:self.menuItems[indexPat.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *menuItem = self.menuItems[indexPath.row];
   ContainerViewController *containerVc = (ContainerViewController *)self.navigationController.parentViewController;
    containerVc.menuItem = menuItem;
}


@end
