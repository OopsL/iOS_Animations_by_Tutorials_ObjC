//
//  GalleryViewController.m
//  iOS_Animations_by_Tutorials_ObjC
//
//  Created by JD.K on 16/7/27.
//  Copyright © 2016年 JD.K. All rights reserved.
//

#import "GalleryViewController.h"
#import "ImageViewCard.h"

@interface GalleryViewController ()

@property(nonatomic, strong) NSArray *imagesArray;

@end

@implementation GalleryViewController

- (NSArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = @[
                         [[ImageViewCard alloc] initWithImageName:@"Hurricane_Katia.jpg" title:@"Hurricane Katia"],
                         [[ImageViewCard alloc] initWithImageName:@"Hurricane_Douglas.jpg" title:@"Hurricane Douglas"],
                         [[ImageViewCard alloc] initWithImageName:@"Hurricane_Norbert.jpg" title:@"Hurricane Norbert"],
                         [[ImageViewCard alloc] initWithImageName:@"Hurricane_Irene.jpg" title:@"Hurricane Irene"]
                         ];
    }
    return _imagesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"info" style:UIBarButtonItemStyleDone target:self action:@selector(info:)];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (ImageViewCard *image in self.imagesArray) {
        image.layer.anchorPoint = CGPointMake(0.5, 0.0);
        image.frame = self.view.bounds;
        [self.view addSubview:image];
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationItem.title = ((ImageViewCard *)[self.imagesArray lastObject]).title;
    
    
    CATransform3D persTransform = CATransform3DIdentity;
    persTransform.m34 = -1.0/250.0;
    self.view.layer.sublayerTransform = persTransform;
}

- (void)info:(UIBarButtonItem *)leftItem
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"Info" message:@"Public Domain images by NASA" preferredStyle:UIAlertControllerStyleAlert];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertVc animated:YES completion:nil];
}
- (IBAction)toggleGallery:(UIBarButtonItem *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
