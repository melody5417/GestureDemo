//
//  ContinuousCustomGestureViewController.m
//  GestureDemo
//
//  Created by yiqiwang(王一棋) on 2017/8/1.
//  Copyright © 2017年 melody5417. All rights reserved.
//

#import "ContinuousCustomGestureViewController.h"
#import "ContinuousCustomGestureRecognizer.h"

@interface ContinuousCustomGestureViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ContinuousCustomGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColorFromRGB(0xD9FAD3);

    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.imageView];
    [self.imageView setImage:[UIImage imageNamed:@"Checkmark"]];
    [self.imageView setAlpha:0.f];

    [self addRecognizer];
}

- (void)addRecognizer {
    ContinuousCustomGestureRecognizer *customPanRecognizer = [ContinuousCustomGestureRecognizer new];
    [customPanRecognizer addTarget:self action:@selector(handleCustomPanRecognizer:)];
    [self.view addGestureRecognizer:customPanRecognizer];
}

- (void)handleCustomPanRecognizer:(ContinuousCustomGestureRecognizer *)recognizer {
    [self drawImageForState:recognizer.state atPoint:[recognizer currentPosition]];

    if (recognizer.state == UIGestureRecognizerStateCancelled
        || recognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.alpha = 0.f;
        }];
    }
}

#pragma mark -
#pragma mark Drawing the image view

- (void)drawImageForState:(UIGestureRecognizerState)state atPoint:(CGPoint)centerPoint {

    NSString *imageName;
    if (state == UIGestureRecognizerStateBegan) {
        imageName = @"Began";
    }
    else if (state == UIGestureRecognizerStateChanged) {
        imageName = @"Changed";
    }
    else if (state == UIGestureRecognizerStateEnded) {
        imageName = @"Ended";
    }
    else if (state == UIGestureRecognizerStateCancelled) {
        imageName = @"Cancelled";
    }

    UIImage *image = [UIImage imageNamed:imageName];
    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.imageView.image = image;
    self.imageView.center = centerPoint;
    self.imageView.alpha = 1.0;
}

@end
