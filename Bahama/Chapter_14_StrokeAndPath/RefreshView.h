//
//  RefreshView.h
//  iOS_Animations_by_Tutorials_ObjC
//
//

#import <UIKit/UIKit.h>

@class RefreshView;

@protocol RefreshViewDelegate <NSObject>

- (void)refreshViewDidRefresh:(RefreshView *)refreshView;

@end

@interface RefreshView : UIView

@property(nonatomic, weak) id<RefreshViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)scrollView;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;

- (void)endRefresh;

@end
