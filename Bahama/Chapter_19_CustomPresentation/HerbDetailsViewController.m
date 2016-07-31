//
//  HerbDetailsViewController.m
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import "HerbDetailsViewController.h"

@interface HerbDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;
@property (weak, nonatomic) IBOutlet UIButton *licenseButton;
@property (weak, nonatomic) IBOutlet UIButton *authorButton;

@end

@implementation HerbDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionClose:)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.bgImage.image = [UIImage imageNamed:self.herbModel.image];
    self.titleView.text = self.herbModel.name;
    self.descriptionView.text = self.herbModel.desc;
    
}

- (IBAction)actionLicense:(id)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:self.herbModel.license]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.herbModel.license]];
    }
}
- (IBAction)actionAuthor:(id)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:self.herbModel.credit]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.herbModel.credit]];
    }
}

- (void)actionClose:(UITapGestureRecognizer *)tap
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
