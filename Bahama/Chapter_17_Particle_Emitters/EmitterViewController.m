//
//  EmitterViewController.m
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import "EmitterViewController.h"

@interface EmitterViewController ()

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

@end

@implementation EmitterViewController

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
    // Do any additional setup after loading the view.
    
    [self.summary addSubview:self.summaryIcon];
    CGPoint center = self.summaryIcon.center;
    center.y = self.summary.bounds.size.height * 0.5;
    self.summaryIcon.center = center;
    [self changeFlightDataTo:self.londonToParis];
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    CGRect rect = CGRectMake(0, -70, self.view.bounds.size.width, 50);
    emitterLayer.frame = rect;
    [self.view.layer addSublayer:emitterLayer];
    
    emitterLayer.emitterShape = kCAEmitterLayerRectangle;
    emitterLayer.emitterPosition = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    emitterLayer.emitterSize = rect.size;
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"flake"].CGImage);
    cell.birthRate = 50;
    cell.lifetime = 3.5;
    cell.lifetimeRange = 1.0;
    cell.yAcceleration = 70.0;
    cell.xAcceleration = 10.0;
    cell.velocity = 20.0;
    cell.emissionLongitude = -M_PI;
    cell.velocityRange = 200;
    cell.emissionRange = M_PI_2;
    cell.color = [UIColor colorWithRed:0.9 green:1.0 blue:1.0 alpha:1.0].CGColor;
    cell.redRange = 0.1;
    cell.greenRange = 0.1;
    cell.blueRange = 0.1;
    cell.scale = 0.8;
    cell.scaleRange = 0.8;
    cell.scaleSpeed = -0.15;
    cell.alphaRange = 0.75;
    cell.alphaSpeed = -0.15;
    
    CAEmitterCell *cell2 = [CAEmitterCell emitterCell];
    cell2.contents = (__bridge id _Nullable)([UIImage imageNamed:@"flake2.png"].CGImage);
    cell2.birthRate = 50;
    cell2.lifetime = 2.5;
    cell2.lifetimeRange = 1.0;
    cell2.yAcceleration = 50;
    cell2.xAcceleration = 50;
    cell2.velocity = 80;
    cell2.emissionLongitude = M_PI;
    cell2.velocityRange = 20;
    cell2.emissionRange = M_PI_4;
    cell2.scale = 0.8;
    cell2.scaleRange = 0.2;
    cell2.scaleSpeed = -0.1;
    cell2.alphaRange = 0.35;
    cell2.alphaSpeed = -0.15;
    cell2.spin = M_PI;
    cell2.spinRange = M_PI;
    
    CAEmitterCell *cell3 = [CAEmitterCell emitterCell];
     cell3.contents = (__bridge id _Nullable)([UIImage imageNamed:@"flake3.png"].CGImage);
    cell3.birthRate = 20;
    cell3.lifetime = 7.5;
    cell3.lifetimeRange = 1.0;
    cell3.yAcceleration = 20;
    cell3.xAcceleration = 10;
    cell3.velocity = 40;
    cell3.emissionLongitude = M_PI;
    cell3.velocityRange = 50;
    cell3.emissionRange = M_PI_4;
    cell3.scale = 0.8;
    cell3.scaleRange = 0.2;
    cell3.scaleSpeed = -0.05;
    cell3.alphaRange = 0.5;
    cell3.alphaSpeed = -0.05;
    
    emitterLayer.emitterCells = @[cell,cell2,cell3];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeFlightDataTo:(NSDictionary *)data
{
    self.summary.text = data[@"summary"];
    self.flightNr.text = data[@"flightNr"];
    self.gateNr.text = data[ @"gateNr"];
    self.departingFrom.text = data[@"departingFrom"];
    self.arrivingTo.text = data[@"arrivingTo"];
    self.flightStatus.text = data[@"flightStatus"];
    self.bgImageView.image = [UIImage imageNamed:data[@"weatherImageName"]];
}

@end
