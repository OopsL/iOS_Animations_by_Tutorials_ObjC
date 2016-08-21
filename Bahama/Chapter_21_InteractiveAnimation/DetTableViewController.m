//
//  DetTableViewController.m
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import "DetTableViewController.h"
#import "RWLogoLayer.h"
#import "RevealAnimator.h"
#import "MasterViewController.h"

@interface DetTableViewController ()
@property(nonatomic, strong) NSArray *packItems;
@property(nonatomic, weak) RevealAnimator *animator;
@end

@implementation DetTableViewController

- (NSArray *)packItems
{
    if ((!_packItems)) {
        _packItems = @[@"Icecream money", @"Great weather", @"Beach ball", @"Swim suit for him", @"Swim suit for her", @"Beach games", @"Ironing board", @"Cocktail mood", @"Sunglasses", @"Flip flops"];
    }
    return _packItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.navigationItem.title = @"Pack List";
    self.tableView.rowHeight = 54;
    
    self.maskLayer = [RWLogoLayer logoLayer];
    self.maskLayer.position = CGPointMake(self.view.layer.bounds.size.width * 0.5, self.view.layer.bounds.size.height * 0.5);
    self.view.layer.mask = self.maskLayer;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.view.layer.mask = nil;
    
    MasterViewController *masterVc = self.navigationController.viewControllers.firstObject;
    if (masterVc) {
        self.animator = masterVc.transition;
    }
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self.view addGestureRecognizer:pan];
    
}

- (void)didPan:(UIPanGestureRecognizer *)pan
{
    if (self.animator) {
        switch (pan.state) {
            case UIGestureRecognizerStateBegan:
                self.animator.interactive = YES;
                [self.navigationController popViewControllerAnimated:YES];
                
                break;
                
            default:
                break;
        }
        [self.animator handlePan:pan];
    }

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
    return self.packItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = self.packItems[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"summericons_100px_0%zd.png",indexPath.row]];
    
    return cell;
}


@end
