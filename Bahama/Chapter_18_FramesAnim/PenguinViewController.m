//
//  PenguinViewController.m
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import "PenguinViewController.h"

#define animDuration 1.0

@interface PenguinViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *penguin;
@property (weak, nonatomic) IBOutlet UIButton *slideButton;
@property(nonatomic, strong) NSArray *walkFrames;
@property(nonatomic, strong) NSArray *slideFrames;
@property(nonatomic, assign) CGSize walkSize;
@property(nonatomic, assign) CGSize slideSize;
@property(nonatomic, assign) CGFloat penguinY;
@property(nonatomic, assign) BOOL isLookingRight;
@end

@implementation PenguinViewController

- (NSArray *)walkFrames
{
    if (!_walkFrames) {
        _walkFrames = @[
                        [UIImage imageNamed:@"walk01"],
                        [UIImage imageNamed:@"walk02"],
                        [UIImage imageNamed:@"walk03"],
                        [UIImage imageNamed:@"walk04"]
                        ];
    }
    return _walkFrames;
}

- (NSArray *)slideFrames
{
    if (!_slideFrames) {
        _slideFrames = @[
                         [UIImage imageNamed:@"slide01"],
                         [UIImage imageNamed:@"slide02"],
                         [UIImage imageNamed:@"slide01"]
                         ];
    }
    return _slideFrames;
}

- (void)setIsLookingRight:(BOOL)isLookingRight
{
    _isLookingRight = isLookingRight;
    CGFloat xScale = isLookingRight ? 1 : -1;
    self.penguin.transform = CGAffineTransformMakeScale(xScale, 1);
    self.slideButton.transform = self.penguin.transform;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *walk0Image = self.walkFrames[0];
    self.walkSize = walk0Image.size;
    UIImage *slide0Image = self.slideFrames[0];
    self.slideSize = slide0Image.size;
    self.penguinY = self.penguin.frame.origin.y;
    
    self.isLookingRight = true;
    
    [self loadWalkAnimation];
}

- (void)loadWalkAnimation
{
    self.penguin.animationImages = self.walkFrames;
    self.penguin.animationDuration = animDuration/3;
    self.penguin.animationRepeatCount = 3;
}

- (void)loadSlideAnimation
{
    self.penguin.animationImages = self.slideFrames;
    self.penguin.animationDuration = animDuration;
}

- (IBAction)actionLeft:(id)sender {
    self.isLookingRight = false;
    [self.penguin startAnimating];
    
    [UIView animateWithDuration:animDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGPoint center = self.penguin.center;
        center.x -= self.penguin.bounds.size.width;
        self.penguin.center = center;
    } completion:nil];
    
}
- (IBAction)actionRight:(id)sender {
    self.isLookingRight = true;
    [self.penguin startAnimating];
    
    [UIView animateWithDuration:animDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGPoint center = self.penguin.center;
        center.x += self.penguin.bounds.size.width;
        self.penguin.center = center;
    } completion:nil];
}
- (IBAction)actionSlide:(id)sender {
    [self loadSlideAnimation];
    
    //适应两组图片大小不同
    self.penguin.frame = CGRectMake(self.penguin.frame.origin.x, self.penguinY + (self.walkSize.height - self.slideSize.height), self.slideSize.width, self.slideSize.height);
    
    [self.penguin startAnimating];
    
    [UIView animateWithDuration:animDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        if (self.isLookingRight) {
            CGPoint center = self.penguin.center;
            center.x += self.penguin.bounds.size.width;
            self.penguin.center = center;
        }else{
            CGPoint center = self.penguin.center;
            center.x -= self.penguin.bounds.size.width;
            self.penguin.center = center;
        }
        
    } completion:^(BOOL finished) {
        
        self.penguin.frame = CGRectMake(self.penguin.frame.origin.x, self.penguinY, self.walkSize.width, self.walkSize.height);
        
        [self loadWalkAnimation];
    }];
    
    
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
