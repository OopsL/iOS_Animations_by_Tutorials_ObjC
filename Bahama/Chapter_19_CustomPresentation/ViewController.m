//
//  ViewController.m
//  Chapter_19_CustomPresentation
//
//

#import "ViewController.h"
#import "HerbModel.h"
#import "HerbDetailsViewController.h"
#import "PopAnimator.h"

#define tagPlus 1000

@interface ViewController ()<UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UIScrollView *listView;
@property(nonatomic, strong) NSArray *herbs;
@property(nonatomic, strong) PopAnimator *transition;
@property(nonatomic, weak) UIImageView *selectedImage;

@end

@implementation ViewController

- (PopAnimator *)transition
{
    if (!_transition) {
        _transition = [[PopAnimator alloc] init];
    }
    return _transition;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;
    self.transition.dismissCompletion = ^(){
        weakSelf.selectedImage.hidden = NO;
    };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.listView.subviews.count < self.herbs.count) {
        [self setupListView];
    }
}

- (void)setupListView
{
    for (int i=0; i<self.herbs.count;i++) {
        HerbModel *model = self.herbs[i];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:model.image]];
        imageView.tag = i + tagPlus;
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        imageView.userInteractionEnabled = YES;
        imageView.layer.cornerRadius = 20.0;
        imageView.layer.masksToBounds = YES;
        [self.listView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapImageView:)];
        [imageView addGestureRecognizer:tap];
    }
    
    self.listView.backgroundColor = [UIColor clearColor];
    [self positionListItems];

}

- (void)positionListItems
{
    CGFloat itemHeight = self.listView.bounds.size.height * 1.33;
    CGFloat aspectRatio = [UIScreen mainScreen].bounds.size.height/[UIScreen mainScreen].bounds.size.width;
    CGFloat itemWidth = itemHeight/aspectRatio;
    CGFloat horizontalPadding = 10.0;
    for (int i=0; i<self.listView.subviews.count; i++) {
        UIImageView *imageView = [self.listView viewWithTag:i+tagPlus];
        imageView.frame = CGRectMake(i * (itemWidth + horizontalPadding) + horizontalPadding, 0.0, itemWidth, itemHeight);
//        NSLog(@"---%@",NSStringFromCGRect(imageView.frame));
    }
    
    self.listView.contentSize = CGSizeMake(self.herbs.count *(itemWidth + horizontalPadding) + horizontalPadding, 0);
}

- (void)didTapImageView:(UITapGestureRecognizer *)tap
{
    self.selectedImage = (UIImageView *)tap.view;
    
    NSInteger tag = tap.view.tag;
    HerbModel *model = self.herbs[tag - tagPlus];
    HerbDetailsViewController *herbVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HerbDetailsViewController"];
    herbVc.transitioningDelegate = self;
    herbVc.herbModel = model;
    [self presentViewController:herbVc animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    self.transition.originFrame = [self.selectedImage.superview convertRect:self.selectedImage.frame toView:nil];
    _transition.presenting = YES;
    self.selectedImage.hidden = YES;
    
    return self.transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.transition.presenting = NO;
    return self.transition;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.bgImage.alpha = (size.width > size.height) ? 0.25 : 0.55;
        [self positionListItems];
    } completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
   
   - (NSArray *)herbs
{
    if (!_herbs) {
        _herbs = @[
                   [[HerbModel alloc] initWithName:@"Basil" image:@"basil.jpg" license:@"http://creativecommons.org/licenses/by-sa/3.0" credit:@"http://commons.wikimedia.org/wiki/User:Castielli" description:@"Basil is commonly used fresh in cooked recipes. In general, it is added at the last moment, as cooking quickly destroys the flavor. The fresh herb can be kept for a short time in plastic bags in the refrigerator, or for a longer period in the freezer, after being blanched quickly in boiling water. The dried herb also loses most of its flavor, and what little flavor remains tastes very different."],
                   [[HerbModel alloc] initWithName:@"Saffron" image:@"saffron.jpg" license:@"http://creativecommons.org/licenses/by-sa/3.0" credit:@"http://commons.wikimedia.org/wiki/User:Lin%C3%A91" description:@"Saffron's aroma is often described by connoisseurs as reminiscent of metallic honey with grassy or hay-like notes, while its taste has also been noted as hay-like and sweet. Saffron also contributes a luminous yellow-orange colouring to foods. Saffron is widely used in Indian, Persian, European, Arab, and Turkish cuisines. Confectioneries and liquors also often include saffron."],
                   [[HerbModel alloc] initWithName:@"Marjoram" image:@"marjorana.jpg" license:@"http://creativecommons.org/licenses/by-sa/3.0" credit:@"http://commons.wikimedia.org/wiki/User:Raul654" description:@"Marjoram is used for seasoning soups, stews, dressings and sauce. Majorana has been scientifically proved to be beneficial in the treatment of gastric ulcer, hyperlipidemia and diabetes. Majorana hortensis herb has been used in the traditional Austrian medicine for treatment of disorders of the gastrointestinal tract and infections."],
                   [[HerbModel alloc] initWithName:@"Rosemary" image:@"rosemary.jpg" license:@"http://www.gnu.org/licenses/old-licenses/fdl-1.2.html" credit:@"http://commons.wikimedia.org/wiki/User:Fir0002" description:@"The leaves, both fresh and dried, are used in traditional Italian cuisine. They have a bitter, astringent taste and are highly aromatic, which complements a wide variety of foods. Herbal tea can be made from the leaves. When burnt, they give off a mustard-like smell and a smell similar to burning wood, which can be used to flavor foods while barbecuing. Rosemary is high in iron, calcium and vitamin B6."],
                   [[HerbModel alloc] initWithName:@"Anise" image:@"anise.jpg" license:@"http://commons.wikimedia.org/wiki/File:AniseSeeds.jpg" credit:@"http://commons.wikimedia.org/wiki/User:Ben_pcc" description:@"Anise is sweet and very aromatic, distinguished by its characteristic flavor. The seeds, whole or ground, are used in a wide variety of regional and ethnic confectioneries, including black jelly beans, British aniseed balls, Australian humbugs, and others. The Ancient Romans often served spiced cakes with aniseseed, called mustaceoe at the end of feasts as a digestive."]
                   ];
    }
    return _herbs;
}

@end
