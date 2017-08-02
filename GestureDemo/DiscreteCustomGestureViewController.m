//
//  DiscreteCustomGestureViewController.m
//  GestureDemo
//
//  Created by yiqiwang(王一棋) on 2017/8/1.
//  Copyright © 2017年 melody5417. All rights reserved.
//

#import "DiscreteCustomGestureViewController.h"
#import "CheckmarkGestureRecognizer.h"

@interface DiscreteCustomGestureViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation DiscreteCustomGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColorFromRGB(0xD9FAD3);

    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.imageView];
    [self.imageView setImage:[UIImage imageNamed:@"Checkmark"]];
    [self.imageView setContentMode:UIViewContentModeCenter];
    self.imageView.center = self.view.center;
    [self.imageView setAlpha:0.f];

    [self addRecognizer];
}

- (void)addRecognizer {
    CheckmarkGestureRecognizer *checkmarkRecognizer = [CheckmarkGestureRecognizer new];
    [checkmarkRecognizer addTarget:self action:@selector(handleCheckmarkRecognizer:)];
    [self.view addGestureRecognizer:checkmarkRecognizer];
}

- (void)handleCheckmarkRecognizer:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateRecognized) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.imageView setFrame:self.view.bounds];
            self.imageView.alpha = 1.f;
        } completion:^(BOOL finished) {
            [self.imageView setFrame:CGRectZero];
            self.imageView.center = self.view.center;
            self.imageView.alpha = 0.f;
        }];
    }
}

@end
