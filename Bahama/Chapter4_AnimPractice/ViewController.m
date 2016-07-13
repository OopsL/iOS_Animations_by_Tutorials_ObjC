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
                           @"showWeatherEffects" : @"0",
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
                         @"showWeatherEffects" : @"1",
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
    
    [self changeFlightDataTo:self.londonToParis];
}

- (void)changeFlightDataTo:(NSDictionary *)data
{
    self.summary.text = data[@"summary"];
    self.flightNr.text = data[@"flightNr"];
    self.gateNr.text = data[@"gateNr"];
    self.departingFrom.text = data[@"departingFrom"];
    self.arrivingTo.text = data[@"arrivingTo"];
    self.flightStatus.text = data[@"flightStatus"];
    self.bgImageView.image = [UIImage imageNamed:data[@"weatherImageName"]];
    self.snowView.hidden = [data[@"showWeatherEffects"] intValue];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self changeFlightDataTo:[data[@"isTakingOff"] intValue]?self.parisToRome:self.londonToParis];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
