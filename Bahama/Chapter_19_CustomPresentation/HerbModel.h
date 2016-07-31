//
//  HerbModel.h
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import <Foundation/Foundation.h>

@interface HerbModel : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *image;
@property(nonatomic, copy) NSString *license;
@property(nonatomic, copy) NSString *credit;
@property(nonatomic, copy) NSString *desc;

- (instancetype)initWithName:(NSString *)name image:(NSString *)image license:(NSString *)license
                      credit:(NSString *)credit description:(NSString *)description;

@end
