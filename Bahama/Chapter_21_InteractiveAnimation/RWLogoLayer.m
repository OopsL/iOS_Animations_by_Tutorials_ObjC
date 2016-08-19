//
//  RWLogoLayer.m
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import "RWLogoLayer.h"

@implementation RWLogoLayer

+ (CAShapeLayer *)logoLayer
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.geometryFlipped = YES;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    
    [path addCurveToPoint:CGPointMake(0.0, 66.97) controlPoint1:CGPointMake(0, 0) controlPoint2:CGPointMake(0, 57.06)];
    
    [path addCurveToPoint:CGPointMake(16, 39) controlPoint1:CGPointMake(27.68 , 66.97) controlPoint2:CGPointMake(42.35,52.75)];
    [path addCurveToPoint:CGPointMake(26, 17) controlPoint1:CGPointMake(17.35, 35.41) controlPoint2:CGPointMake(26, 17)];
    
    [path addLineToPoint:CGPointMake(38, 34)];
    [path addLineToPoint:CGPointMake(49, 17)];
    [path addLineToPoint:CGPointMake(67, 51.27)];
    [path addLineToPoint:CGPointMake(67, 0)];
    [path addLineToPoint:CGPointMake(0, 0)];
    
    layer.path = path.CGPath;
    layer.bounds = CGPathGetBoundingBox(layer.path);
    
    return layer;
}

@end
