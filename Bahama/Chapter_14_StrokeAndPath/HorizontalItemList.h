//
//  HorizontalItemList.h
//  iOS_Animations_by_Tutorials_ObjC
//

#import <UIKit/UIKit.h>


typedef void(^didSelectItem)(NSInteger);

@interface HorizontalItemList : UIScrollView

@property(nonatomic, copy) didSelectItem selectItem;

@end
