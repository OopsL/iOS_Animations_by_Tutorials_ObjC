//
//  ViewController.m
//  Chapter4_AnimPractice
//
//  Created by JD.K on 16/7/12.
//  Copyright © 2016年 JD.K. All rights reserved.
//

#import "ViewController.h"
#import "SnowView.h"
#import "UIView+Extension.h"

typedef enum : NSInteger {
    Positive = 1,
    Negative = -1
} AnimationDirection;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flightNr;
@property (weak, nonatomic) IBOutlet UILabel *gateNr;
@property (weak, nonatomic) IBOutlet UILabel *departingFrom;
@property (weak, nonatomic) IBOutlet UILabel *arrivingTo;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *planeImage;
@property (weak, nonatomic) IBOutlet UILabel *flightStatus;
@property (weak, nonatomic) IBOutlet UIImageView *statusBanner;
@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet UIImageView *summaryIcon;

@property(nonatomic, strong) NSDictionary *londonToParis;
@property(nonatomic, strong) NSDictionary *parisToRome;

@property(nonatomic, weak) SnowView *snowView;

@end

@implementation ViewController

- (NSDictionary *)londonToParis
{
    if (!_londonToParis) {
        _londonToParis = @{
                           @"summary" : @"01 Apr 2015 09:42",
                           @"flightNr" : @"ZY 2014",
                           @"gateNr" : @"T1 A33",
                           @"departingFrom" : @"LGW",
                           @"arrivingTo" : @"CDG",
                           @"weatherImageName" : @"bg-snowy",
                           @"showWeatherEffects" : @"1",
                           @"isTakingOff" : @"1",
                           @"flightStatus" : @"Boarding"
                           };
    }
    return _londonToParis;
}

- (NSDictionary *)parisToRome
{
    if (!_parisToRome) {
        _parisToRome = @{
                         @"summary" : @"01 Apr 2015 17:05",
                         @"flightNr" : @"AE 1107",
                         @"gateNr" : @"045",
                         @"departingFrom" : @"CDG",
                         @"arrivingTo" : @"FCO",
                         @"weatherImageName" : @"bg-sunny",
                         @"showWeatherEffects" : @"0",
                         @"isTakingOff" : @"0",
                         @"flightStatus" : @"Delayed"
                         };
    }
    return _parisToRome;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.summary addSubview:self.summaryIcon];
    self.summaryIcon.centerY = self.summary.height * 0.5;
    
    SnowView *snow = [[SnowView alloc] initWithFrame:CGRectMake(-150, -100, 300, 50)];
    UIView *snowClipView = [[UIView alloc] initWithFrame:CGRectOffset(self.view.frame, 0, 50)];
    snowClipView.clipsToBounds = YES;
    self.snowView = snow;
    [snowClipView addSubview:snow];
    [self.view addSubview:snowClipView];
    
    [self changeFlightDataTo:self.londonToParis animated:NO];
}

- (void)changeFlightDataTo:(NSDictionary *)data animated:(BOOL)animated
{
    if (animated) {
        [self fadeImageView:self.bgImageView image:[UIImage imageNamed:data[@"weatherImageName"]] showEffects:[data[@"showWeatherEffects"] intValue]];
        
        AnimationDirection direction = [data[@"isTakingOff"] intValue] ? Positive : Negative;
        [self cubeTransition:self.flightNr text:data[@"flightNr"] direction:direction];
        [self cubeTransition:self.gateNr text:data[@"gateNr"] direction:direction];
        
        CGPoint offsetDepart = CGPointMake(direction * 80.0, 0.0);
        [self moveLabel:self.departingFrom text:data[@"departingFrom"] offset:offsetDepart];
        
        CGPoint offsetArrive = CGPointMake(0.0, direction * 50.0);
        [self moveLabel:self.arrivingTo text:data[@"arrivingTo"] offset:offsetArrive];
    }else{
        self.bgImageView.image = [UIImage imageNamed:data[@"weatherImageName"]];
        self.snowView.hidden = ![data[@"showWeatherEffects"] intValue];
    
        self.flightNr.text = data[@"flightNr"];
        self.gateNr.text = data[@"gateNr"];
        
        self.departingFrom.text = data[@"departingFrom"];
        self.arrivingTo.text = data[@"arrivingTo"];
    }
    
    self.summary.text = data[@"summary"];
    self.flightStatus.text = data[@"flightStatus"];


    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self changeFlightDataTo:[data[@"isTakingOff"] intValue]?self.parisToRome:self.londonToParis animated:YES];
    });
}

- (void)fadeImageView:(UIImageView *)imageView image:(UIImage *)image showEffects:(BOOL)showEffects
{
    [UIView transitionWithView:imageView duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        imageView.image = image;
    } completion:nil];
    [UIView animateWithDuration:1.0 animations:^{
        self.snowView.alpha = showEffects ? 1.0 : 0.0;
    }];
}

/**
 *  Label仿3D动画
 */
- (void)cubeTransition:(UILabel *)label text:(NSString *)text direction:(AnimationDirection)direction
{
    UILabel *auxLabel = [[UILabel alloc] initWithFrame:label.frame];
    auxLabel.text = text;
    auxLabel.font = label.font;
    auxLabel.textAlignment = label.textAlignment;
    auxLabel.textColor = label.textColor;
    auxLabel.backgroundColor = [UIColor clearColor];
    CGFloat auxLabelOffset = direction * label.height * 0.5;
    auxLabel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 0.1), CGAffineTransformMakeTranslation(0.0, auxLabelOffset));
    
    [label.superview addSubview:auxLabel];
    
    //动画
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        auxLabel.transform = CGAffineTransformIdentity;
        label.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 0.1), CGAffineTransformMakeTranslation(0.0, -auxLabelOffset));
    } completion:^(BOOL finished) {
        label.text = text;
        label.transform = CGAffineTransformIdentity;
        [auxLabel removeFromSuperview];
    }];
    
}

- (void)moveLabel:(UILabel *)label text:(NSString *)text offset:(CGPoint)offset
{
    UILabel *auxLabel = [[UILabel alloc] initWithFrame:label.frame];
    auxLabel.text = text;
    auxLabel.font = label.font;
    auxLabel.textAlignment = label.textAlignment;
    auxLabel.textColor = label.textColor;
    auxLabel.backgroundColor = [UIColor clearColor];
    
    auxLabel.transform = CGAffineTransformMakeTranslation(offset.x, offset.y);
    auxLabel.alpha = 0;
    [label.superview addSubview:auxLabel];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        label.transform = CGAffineTransformMakeTranslation(offset.x, offset.y);
        label.alpha = 0.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.25 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        auxLabel.transform = CGAffineTransformIdentity;
        auxLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
        label.text =text;
        label.alpha = 1.0;
        label.transform = CGAffineTransformIdentity;
        [auxLabel removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
