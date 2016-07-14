//
//  SnowView.m
//  Bahama

#import "SnowView.h"

@implementation SnowView

+ (Class)layerClass
{
    return [CAEmitterLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initEmitter];
    }
    return self;
}

- (void)initEmitter
{
    CAEmitterLayer *emitterL = (CAEmitterLayer *)self.layer;
    emitterL.emitterPosition = CGPointMake(self.bounds.size.width * 0.5, 0);
    emitterL.emitterSize = self.bounds.size;
    emitterL.emitterShape = kCAEmitterLayerRectangle;
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.contents = (id)[UIImage imageNamed:@"snowflake1"].CGImage;
    cell.birthRate = 200;
    cell.lifetime = 3.5;
    cell.color = [UIColor whiteColor].CGColor;
    cell.redRange = 0.0;
    cell.blueRange = 0.1;
    cell.greenRange = 0.0;
    cell.velocity = 10;
    cell.velocityRange = 350;
    cell.emissionRange = M_PI_2;
    cell.emissionLongitude = -M_PI;
    cell.yAcceleration = 70;
    cell.xAcceleration = 0;
    cell.scale = 0.33;
    cell.scaleRange = 1.25;
    cell.scaleSpeed = -0.25;
    cell.alphaRange = 0.5;
    cell.alphaSpeed = -0.15;
    emitterL.emitterCells = @[cell];
}

@end
