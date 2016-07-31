//
//  HerbModel.m
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import "HerbModel.h"

@interface HerbModel()


@end

@implementation HerbModel

- (instancetype)initWithName:(NSString *)name image:(NSString *)image license:(NSString *)license credit:(NSString *)credit description:(NSString *)description
{
    if (self = [super init]) {
        self.name = name;
        self.image = image;
        self.license = license;
        self.credit = credit;
        self.desc = description;
    }
    return self;
}

@end
