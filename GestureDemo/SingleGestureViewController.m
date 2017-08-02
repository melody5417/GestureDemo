//
//  SingleGestureViewController.m
//  GestureDemo
//
//  Created by yiqiwang(王一棋) on 2017/7/31.
//  Copyright © 2017年 melody5417. All rights reserved.
//

#import "SingleGestureViewController.h"

@interface SingleGestureViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SingleGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColorFromRGB(0xD9FAD3);

    self.imageView = [UIImageView new];
    [self.view addSubview:self.imageView];

    [self addRecognizer];
}

- (void)addRecognizer {
    NSString *item = self.item;

    if ([item isEqualToString:@"Tap"]) {
        UITapGestureRecognizer *tapRecognizer = [UITapGestureRecognizer new];
        [tapRecognizer addTarget:self action:@selector(handleTapRecognizer:)];
        [self.view addGestureRecognizer:tapRecognizer];
    }
    else if ([item isEqualToString:@"EdgePan"]) {
        UIScreenEdgePanGestureRecognizer *edgePanGesture = [UIScreenEdgePanGestureRecognizer new];
        [edgePanGesture addTarget:self action:@selector(handleEdgePanGesture:)];
        [self.view addGestureRecognizer:edgePanGesture];
        [edgePanGesture setEdges:UIRectEdgeRight];
        [edgePanGesture setDelegate:self];
    }
    else if ([item isEqualToString:@"LongPress"]) {
        UILongPressGestureRecognizer *longPressRecognizer = [UILongPressGestureRecognizer new];
        [longPressRecognizer addTarget:self action:@selector(handleLongPressGesture:)];
        [self.view addGestureRecognizer:longPressRecognizer];
        [longPressRecognizer setDelegate:self];
    }
    else if ([item isEqualToString:@"Pan"]) {
        UIPanGestureRecognizer *panRecognizer = [UIPanGestureRecognizer new];
        [panRecognizer addTarget:self action:@selector(handlePanRecognizer:)];
        [self.view addGestureRecognizer:panRecognizer];
        [panRecognizer setDelegate:self];
    }
    else if ([item isEqualToString:@"Pinch"]) {
        UIPinchGestureRecognizer *pinchRecognizer = [UIPinchGestureRecognizer new];
        [pinchRecognizer addTarget:self action:@selector(handlePinchRecognizer:)];
        [self.view addGestureRecognizer:pinchRecognizer];
        [pinchRecognizer setDelegate:self];
    }
    else if ([item isEqualToString:@"Rotate"]) {
        UIRotationGestureRecognizer *rotateRecognizer = [UIRotationGestureRecognizer new];
        [rotateRecognizer addTarget:self action:@selector(handleRotateRecognizer:)];
        [self.view addGestureRecognizer:rotateRecognizer];
        [rotateRecognizer setDelegate:self];
    }
    else if ([item isEqualToString:@"Swipe"]) {
        UISwipeGestureRecognizer *swipeLeftRecognizer = [UISwipeGestureRecognizer new];
        [swipeLeftRecognizer addTarget:self action:@selector(handleSwipeRecognizer:)];
        [self.view addGestureRecognizer:swipeLeftRecognizer];
        [swipeLeftRecognizer setDelegate:self];
        swipeLeftRecognizer.numberOfTouchesRequired = 1;
        swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    }
}

#pragma mark - handle gestures

- (void)handleTapRecognizer:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.view];
    [self drawImageForGestureRecognizer:recognizer atPoint:location];

    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.alpha = 0.0;
    }];
}

- (void)handlePinchRecognizer:(UIPinchGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.view];

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self drawImageForGestureRecognizer:recognizer atPoint:location];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"scale %f", recognizer.scale);

        CGAffineTransform transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);
        self.imageView.transform = transform;
    }
    else if (recognizer.state == UIGestureRecognizerStateCancelled
             || recognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.alpha = 0.0;
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    }

    //    recognizer.scale = 1.f;
}

- (void)handlePanRecognizer:(UIPanGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.view];

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self drawImageForGestureRecognizer:recognizer atPoint:location];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:self.view];
        NSLog(@"translation %@", NSStringFromCGPoint(translation));

        CGAffineTransform transform = CGAffineTransformMakeTranslation(translation.x, translation.y);
        self.imageView.transform = transform;
    }
    else if (recognizer.state == UIGestureRecognizerStateCancelled
             || recognizer.state == UIGestureRecognizerStateEnded) {

        CGPoint translation = [recognizer translationInView:self.view];

        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.center = CGPointMake(self.imageView.center.x + translation.x, self.imageView.center.y + translation.y);
            self.imageView.alpha = 0.0;
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    }

    //        [recognizer setTranslation:CGPointZero inView:self.view];
}

- (void)handleSwipeRecognizer:(UISwipeGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {

        CGPoint location = [recognizer locationInView:self.view];
        [self drawImageForGestureRecognizer:recognizer atPoint:location];

        if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
            location.x -= 220.0;
        }
        else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
            location.x += 220.0;
        }
        else if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
            location.y -= 220;
        }
        else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
            location.y += 220;
        }

        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.alpha = 0.0;
            self.imageView.center = location;
        }];
    }
}

- (void)handleRotateRecognizer:(UIRotationGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:self.view];
        [self drawImageForGestureRecognizer:recognizer atPoint:location];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGAffineTransform transform = CGAffineTransformMakeRotation(recognizer.rotation);
        self.imageView.transform = transform;
    }
    else if (recognizer.state == UIGestureRecognizerStateCancelled
             || recognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.alpha = 0.0;
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    }

    //    recognizer.rotation = 0.f;
}

- (IBAction)handleGesture:(UIGestureRecognizer *)recognizer
{

    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            CGPoint location = [recognizer locationInView:self.view];
            [self drawImageForGestureRecognizer:recognizer atPoint:location];
            break;
        }

        case UIGestureRecognizerStateEnded: {
            [UIView animateWithDuration:0.5 animations:^{
                self.imageView.alpha = 0.0;
                self.imageView.transform = CGAffineTransformIdentity;
            }];
            break;
        }

        case UIGestureRecognizerStateChanged: {
            self.imageView.transform = [self applyRecognizer:recognizer toTransform:self.imageView.transform];
            break;
        }

        default:
            break;
    }

    if ([recognizer respondsToSelector:@selector(rotation)]) {
        [(UIRotationGestureRecognizer *)recognizer setRotation:0.f];
    }
    else if ([recognizer respondsToSelector:@selector(scale)]) {
        [(UIPinchGestureRecognizer *)recognizer setScale:1.f];
    }

}

- (void)handleLongPressGesture:(UIRotationGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:self.view];
        [self drawImageForGestureRecognizer:recognizer atPoint:location];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.alpha = 0.0;
        }];
    }
}

- (void)handleEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan
        || recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint location = [recognizer locationInView:self.view];
        [self drawImageForGestureRecognizer:recognizer atPoint:location];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.alpha = 0.0;
        }];
    }
}

#pragma mark -

- (CGAffineTransform)applyRecognizer:(UIGestureRecognizer *)recognizer toTransform:(CGAffineTransform)transform {
    if ([recognizer respondsToSelector:@selector(rotation)])
        return CGAffineTransformRotate(transform, [(UIRotationGestureRecognizer *)recognizer rotation]);
    else if ([recognizer respondsToSelector:@selector(scale)]) {
        CGFloat scale = [(UIPinchGestureRecognizer *)recognizer scale];
        return CGAffineTransformScale(transform, scale, scale);
    }
    else
        return transform;
}

#pragma mark -
#pragma mark Drawing the image view

- (void)drawImageForGestureRecognizer:(UIGestureRecognizer *)recognizer atPoint:(CGPoint)centerPoint {

    NSString *imageName;

    if ([recognizer isMemberOfClass:[UITapGestureRecognizer class]]) {
        imageName = @"Tap";
    }
    else if ([recognizer isMemberOfClass:[UIPinchGestureRecognizer class]]) {
        imageName = @"Pinch";
    }
    else if ([recognizer isMemberOfClass:[UIPanGestureRecognizer class]]) {
        imageName = @"Pan";
    }
    else if ([recognizer isMemberOfClass:[UISwipeGestureRecognizer class]]) {
        imageName = @"Swipe";
    }
    else if ([recognizer isMemberOfClass:[UIRotationGestureRecognizer class]]) {
        imageName = @"Rotate";
    }
    else if ([recognizer isMemberOfClass:[UILongPressGestureRecognizer class]]) {
        imageName = @"LongPress";
    }
    else if ([recognizer isMemberOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        imageName = @"EdgePan";
    }

    UIImage *image = [UIImage imageNamed:imageName];
    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.imageView.image = image;
    self.imageView.center = centerPoint;
    self.imageView.alpha = 1.0;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

    // don't allow pan when pinch
    if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]
        && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return NO;
    }
    else if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]
             && [otherGestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]) {
        return NO;
    }

    // don't allow pan when longPress
    else if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]
             && [otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        return NO;
    }

    // don't allow pan when longPress
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]
        && [otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        return NO;
    }
    else if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]
             && [otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        return NO;
    }

    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}


@end
