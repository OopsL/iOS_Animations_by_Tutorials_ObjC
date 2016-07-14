//
//  ViewController.m
//  Chapter_6_PackingList
//
//  Created by JD.K on 16/7/14.
//  Copyright © 2016年 JD.K. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) NSArray *items;

@end


@implementation ViewController


- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"Icecream money", @"Great weather", @"Beach ball", @"Swim suit for him", @"Swim suit for her", @"Beach games", @"Ironing board", @"Cocktail mood", @"Sunglasses", @"Flip flops"];
    }
    return _dataArray;
}

- (NSArray *)items
{
    if (!_items) {
        _items = @[@5,@6,@7,];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.rowHeight = 54;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = self.dataArray[[self.items[indexPath.row] integerValue]];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"summericons_100px_0%zd",[self.items[indexPath.row] integerValue]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
