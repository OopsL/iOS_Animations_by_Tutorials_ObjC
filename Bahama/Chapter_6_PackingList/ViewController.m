//
//  ViewController.m
//  Chapter_6_PackingList
//

#import "ViewController.h"
#import "HorizontalItemList.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) NSMutableArray *items;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuHeightConstraint;
@property(nonatomic, assign,getter=isMenuOpen) BOOL menuOpen;

@property(nonatomic, weak) HorizontalItemList *list;

@end


@implementation ViewController


- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"Icecream money", @"Great weather", @"Beach ball", @"Swim suit for him", @"Swim suit for her", @"Beach games", @"Ironing board", @"Cocktail mood", @"Sunglasses", @"Flip flops"];
    }
    return _dataArray;
}

- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray arrayWithObjects: @5,@6,@7, nil];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.rowHeight = 54;
    
}
- (IBAction)actionToggleMenu:(UIButton *)sender {
    
    self.menuOpen = !self.menuOpen;
    
    //改变Title constraint的值
    for (NSLayoutConstraint *constraint in self.titleLabel.superview.constraints) {
        NSLog(@"%@",constraint);
        
        if (constraint.firstItem == self.titleLabel && constraint.firstAttribute == NSLayoutAttributeCenterX) {
            constraint.constant = self.isMenuOpen ? -100 : 0.0;
            continue;
        }
        //replace constraint
        if ([constraint.identifier isEqual: @"TitleCenterY"]) {
            constraint.active = false;
            NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.titleLabel.superview attribute:NSLayoutAttributeCenterY multiplier:self.isMenuOpen?0.67:1.0 constant:5.0];
            newConstraint.identifier = @"TitleCenterY";
            newConstraint.active = true;
            
            continue;
        }
        
        
    }
    self.menuHeightConstraint.constant = self.isMenuOpen ? 200 : 60;
    self.titleLabel.text = self.isMenuOpen ? @"Select Item" : @"Packing List";
    
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view layoutIfNeeded];
        
        CGFloat btnAngle = self.isMenuOpen ? M_PI_4 : 0.0;
        self.addBtn.transform = CGAffineTransformMakeRotation(btnAngle);
        
    } completion:nil];
    
    if (self.isMenuOpen) {
        HorizontalItemList *list = [[HorizontalItemList alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, 120, self.view.bounds.size.width, 80)];
        list.selectItem = ^(NSInteger index){
            [self.items addObject:@(index)];
            [self.tableView reloadData];
            [self actionToggleMenu:nil];
        };
        self.list = list;
        [self.titleLabel.superview addSubview:list];
    }else{
        [self.list removeFromSuperview];
    }
    
}

- (void)showItem:(NSInteger)index
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"summericons_100px_0%zd",index]]];
    imageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    imageView.layer.cornerRadius = 5.0;
    imageView.layer.masksToBounds = YES;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imageView];
    
    //添加约束
    NSLayoutConstraint *conX = [imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor];
    NSLayoutConstraint *conBottom = [imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:imageView.frame.size.height];
    NSLayoutConstraint *conWidth = [imageView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.33 constant:-50];
    NSLayoutConstraint *conHeight = [imageView.heightAnchor constraintEqualToAnchor:imageView.widthAnchor];
    [NSLayoutConstraint activateConstraints:@[conX,conBottom,conWidth,conHeight]];
    
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.8 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:0 animations:^{
        conBottom.constant = -imageView.frame.size.height * 0.5;
        conWidth.constant = 0.0;
        [self.view layoutIfNeeded];
    } completion:nil];
    
    [UIView animateWithDuration:0.8 delay:1.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:0 animations:^{
        conBottom.constant = imageView.frame.size.height;
        conWidth.constant = -50.0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
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
    [self showItem:indexPath.row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
