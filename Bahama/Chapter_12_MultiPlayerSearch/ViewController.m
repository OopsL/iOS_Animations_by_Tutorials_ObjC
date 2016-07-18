//
//  ViewController.m
//  Chapter_12_MultiPlayerSearch
//
//

#import "ViewController.h"
#import "AvatarView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *vs;
@property (weak, nonatomic) IBOutlet AvatarView *opponentAvatar;
@property (weak, nonatomic) IBOutlet AvatarView *mAvatar;
@property (weak, nonatomic) IBOutlet UIButton *searchAgain;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self searchOpponent];
    
}

- (void)searchOpponent
{
    CGSize avatarSize = self.mAvatar.frame.size;
    CGFloat bounceXOffset = avatarSize.width/1.9;
    CGPoint rightBouncePoint = CGPointMake(self.view.frame.size.width * 0.5 + bounceXOffset, self.mAvatar.center.y);
    CGPoint leftBouncePoint = CGPointMake(self.view.frame.size.width * 0.5 - bounceXOffset, self.opponentAvatar.center.y);
    
    CGSize morphSize = CGSizeMake(avatarSize.width * 0.85, avatarSize.height * 1.1);
    [self.mAvatar bounceOffPoint:rightBouncePoint morphSize:morphSize];
    [self.opponentAvatar bounceOffPoint:leftBouncePoint morphSize:morphSize];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self findOpponent];
    });
}

- (void)findOpponent
{
    self.status.text = @"Conecting...";
    self.opponentAvatar.avatarImage = [UIImage imageNamed:@"avatar-2"];
    self.opponentAvatar.name = @"Ray";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self connectedCompleted];
    });
}

- (void)connectedCompleted
{
    self.mAvatar.shouldTransitionToFinishedState = YES;
    self.opponentAvatar.shouldTransitionToFinishedState = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self findCompleted];
    });
}

- (void)findCompleted
{
    self.status.text = @"Ready to play";
    [UIView animateWithDuration:0.2 animations:^{
        self.vs.alpha = 1.0;
        self.searchAgain.alpha = 1.0;
    }];
}

- (IBAction)actionSearchAgain:(UIButton *)sender {
    [UIApplication sharedApplication].keyWindow.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
