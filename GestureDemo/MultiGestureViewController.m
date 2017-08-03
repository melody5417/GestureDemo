//
//  MultiGestureViewController.m
//  GestureDemo
//
//  Created by yiqiwang(王一棋) on 2017/8/2.
//  Copyright © 2017年 melody5417. All rights reserved.
//

#import "MultiGestureViewController.h"

@interface MultiGestureViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *purpleView;
@property (nonatomic, strong) UIView *blueView;

@end

@implementation MultiGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColorFromRGB(0xD9FAD3);
    
    self.purpleView = [UIView new];
    [self.view addSubview:self.purpleView];
    [self.purpleView setFrame:CGRectMake(80, 80, 100, 100)];
    self.purpleView.backgroundColor = UIColorFromRGB(0xAE5AE3);

    self.blueView = [UIView new];
    [self.view addSubview:self.blueView];
    [self.blueView setFrame:CGRectMake(100, 100, 50, 50)];
    self.blueView.backgroundColor = UIColorFromRGB(0x62A7F7);

    [self addRecognizer];
}

- (void)addRecognizer {
    UIPanGestureRecognizer *purplePanGesture = [UIPanGestureRecognizer new];
    [purplePanGesture addTarget:self action:@selector(handlePanRecognizer:)];
    [self.purpleView addGestureRecognizer:purplePanGesture];
    [purplePanGesture setDelegate:self];

    UIPanGestureRecognizer *bluePanGesture = [UIPanGestureRecognizer new];
    [bluePanGesture addTarget:self action:@selector(handlePanRecognizer:)];
    [self.blueView addGestureRecognizer:bluePanGesture];
    [bluePanGesture setDelegate:self];

    UIRotationGestureRecognizer *purpleRotateGesture = [UIRotationGestureRecognizer new];
    [purpleRotateGesture addTarget:self action:@selector(handleRotateRecognizer:)];
    [self.purpleView addGestureRecognizer:purpleRotateGesture];
    [purpleRotateGesture setDelegate:self];

    UIRotationGestureRecognizer *blueRotateGesture = [UIRotationGestureRecognizer new];
    [blueRotateGesture addTarget:self action:@selector(handleRotateRecognizer:)];
    [self.blueView addGestureRecognizer:blueRotateGesture];
    [blueRotateGesture setDelegate:self];

    UIPinchGestureRecognizer *purplePinchGesture = [UIPinchGestureRecognizer new];
    [purplePinchGesture addTarget:self action:@selector(handlePinchRecognizer:)];
    [self.purpleView addGestureRecognizer:purplePinchGesture];
    [purplePinchGesture setDelegate:self];

    UIPinchGestureRecognizer *bluePinchGesture = [UIPinchGestureRecognizer new];
    [bluePinchGesture addTarget:self action:@selector(handlePinchRecognizer:)];
    [self.blueView addGestureRecognizer:bluePinchGesture];
    [bluePinchGesture setDelegate:self];

    UITapGestureRecognizer *purpleTapGesture = [UITapGestureRecognizer new];
    purpleTapGesture.numberOfTapsRequired = 2;
    [purpleTapGesture addTarget:self action:@selector(handleTapRecognizer:)];
    [self.purpleView addGestureRecognizer:purpleTapGesture];
    [purpleTapGesture setDelegate:self];

    UITapGestureRecognizer *blueTapGesture = [UITapGestureRecognizer new];
    blueTapGesture.numberOfTapsRequired = 2;
    [blueTapGesture addTarget:self action:@selector(handleTapRecognizer:)];
    [self.blueView addGestureRecognizer:blueTapGesture];
    [blueTapGesture setDelegate:self];

    UITapGestureRecognizer *purpleSingleTapGesture = [UITapGestureRecognizer new];
    purpleSingleTapGesture.numberOfTapsRequired = 1;
    [purpleSingleTapGesture addTarget:self action:@selector(handleSingleTapRecognizer:)];
    [self.purpleView addGestureRecognizer:purpleSingleTapGesture];
    [purpleSingleTapGesture setDelegate:self];
}

#pragma mark - handle gestures

- (void)handlePinchRecognizer:(UIPinchGestureRecognizer *)recognizer {
    [self adjustAnchorPointForGestureRecognizer:recognizer];

    if ([recognizer state] == UIGestureRecognizerStateBegan
        || [recognizer state] == UIGestureRecognizerStateChanged) {
        [recognizer view].transform = CGAffineTransformScale([[recognizer view] transform], [recognizer scale], [recognizer scale]);
        [recognizer setScale:1];
    }
}

- (void)handlePanRecognizer:(UIPanGestureRecognizer *)recognizer {
    UIView *piece = [recognizer view];

    [self adjustAnchorPointForGestureRecognizer:recognizer];

    if ([recognizer state] == UIGestureRecognizerStateBegan
        || [recognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:[piece superview]];

        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [recognizer setTranslation:CGPointZero inView:[piece superview]];
    }
}

- (void)handleRotateRecognizer:(UIRotationGestureRecognizer *)recognizer {
    [self adjustAnchorPointForGestureRecognizer:recognizer];

    if ([recognizer state] == UIGestureRecognizerStateBegan
        || [recognizer state] == UIGestureRecognizerStateChanged) {
        [recognizer view].transform = CGAffineTransformRotate([[recognizer view] transform], [recognizer rotation]);
        [recognizer setRotation:0];
    }
}

- (void)handleTapRecognizer:(UITapGestureRecognizer *)recognizer {
    [self adjustAnchorPointForGestureRecognizer:recognizer];

    [recognizer view].transform = CGAffineTransformScale([recognizer.view transform], 1.5, 1.5);
}

- (void)handleSingleTapRecognizer:(UITapGestureRecognizer *)recognizer {
    [self adjustAnchorPointForGestureRecognizer:recognizer];
    
    CGPoint locationInPurpleView = [recognizer locationInView:recognizer.view];
    CGPoint locationInSelfView = [recognizer locationInView:self.view];
    
    NSLog(@"%@ %@", NSStringFromCGPoint(locationInPurpleView), NSStringFromCGPoint(locationInSelfView));

    [recognizer view].center = [recognizer locationInView:self.view];
}

#pragma mark - UIGestureRecognizerDelegate

/**
 Ensure that the pinch, pan and rotate gesture recognizers on a particular view can all recognize simultaneously.
 Prevent other gesture recognizers from recognizing simultaneously.
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // If the gesture recognizers's view isn't one of our pieces, don't allow simultaneous recognition.
    if (gestureRecognizer.view != self.purpleView
        && gestureRecognizer.view != self.blueView ) {
        return NO;
    }

    // If the gesture recognizers are on different views, don't allow simultaneous recognition.
    if (gestureRecognizer.view != otherGestureRecognizer.view) {
        return NO;
    }

    // If either of the gesture recognizers is the tap, don't allow simultaneous recognition.
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        return NO;
    }

    return YES;
}

/**
 Asks the delegate if the current gesture recognizer must fail before another gesture recognizer is allowed to recognize its gesture.
 Ensure that double tap on purpelview must faile before single tap is allowed to recognize. The single tap will delay a little.
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer.view == self.purpleView
        && otherGestureRecognizer.view == self.purpleView
        && [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]
        && [otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]
        && [(UITapGestureRecognizer *)gestureRecognizer numberOfTapsRequired] == 2
        && [(UITapGestureRecognizer *)otherGestureRecognizer numberOfTapsRequired] == 1) {
        return YES;
    }
    
    return NO;
}

#pragma mark - Utility methods

/**
 Scale and rotation transforms are applied relative to the layer's anchor point this method moves a gesture recognizer's view's anchor point between the user's fingers.
 */
- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];

        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

@end
