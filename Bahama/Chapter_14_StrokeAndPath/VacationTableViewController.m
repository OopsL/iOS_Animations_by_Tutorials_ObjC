//
//  VacationTableViewController.m
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import "VacationTableViewController.h"
#import "RefreshView.h"

#define kRefreshHeight 110

@interface VacationTableViewController ()<RefreshViewDelegate>

@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) NSMutableArray *items;
@property(nonatomic, weak) RefreshView *refreshView;

@end

@implementation VacationTableViewController

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
        _items = [NSMutableArray arrayWithObjects: @5,@6,@7,@5,@6,@2,@3,@6,@1,@4,@6,@0, nil];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.rowHeight = 54;
    
//    self.view.backgroundColor = [UIColor colorWithRed:0.0 green:154.0/255.0 blue:222.0/255.0 alpha:1.0];
    self.view.backgroundColor = [UIColor redColor];
    
    RefreshView *refreshView = [[RefreshView alloc] initWithFrame:CGRectMake(0, -kRefreshHeight, self.view.bounds.size.width, kRefreshHeight) scrollView:self.tableView];
    self.refreshView = refreshView;
    refreshView.delegate = self;
    [self.view addSubview:refreshView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.refreshView scrollViewDidScroll:scrollView];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self.refreshView scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"contentInset = %@",NSStringFromUIEdgeInsets(self.tableView.contentInset));
    NSLog(@"contentOffset = %@",NSStringFromCGPoint(self.tableView.contentOffset));
}

#pragma mark RefreshViewDelegate
- (void)refreshViewDidRefresh:(RefreshView *)refreshView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshView endRefresh];
    });
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
