//
//  ViewController.m
//  Chapter_12_MultiPlayerSearch
//
//  Created by wukai on 16/7/16.
//  Copyright © 2016年 JD.K. All rights reserved.
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
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
