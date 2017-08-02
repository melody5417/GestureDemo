//
//  ContinuousCustomGestureRecognizer.m
//  GestureDemo
//
//  Created by yiqiwang(王一棋) on 2017/8/1.
//  Copyright © 2017年 melody5417. All rights reserved.
//

#import "ContinuousCustomGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface ContinuousCustomGestureRecognizer ()

@property (nonatomic, strong) UITouch *trackedTouch;
@property (nonatomic, assign, readwrite) CGPoint currentPosition;

@end

@implementation ContinuousCustomGestureRecognizer

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    if (touches.count != 1) {
        self.state = UIGestureRecognizerStateFailed;
    }

    if (self.trackedTouch == nil
        && touches.anyObject) {
        self.trackedTouch = touches.anyObject;
        self.currentPosition = [self.trackedTouch locationInView:self.view];
        self.state = UIGestureRecognizerStateBegan;
    }
    else {
        for (UITouch *touch in touches) {
            if (touch != self.trackedTouch) {
                self.state = UIGestureRecognizerStateCancelled;
            }
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];

    self.currentPosition = [self.trackedTouch locationInView:self.view];
    self.state = UIGestureRecognizerStateChanged;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];

    self.currentPosition = [self.trackedTouch locationInView:self.view];
    self.state = UIGestureRecognizerStateEnded;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];

    self.currentPosition = [self.trackedTouch locationInView:self.view];
    self.state = UIGestureRecognizerStateCancelled;
}

- (void)reset {
    [super reset];

    self.trackedTouch = nil;
    self.currentPosition = CGPointZero;
    self.state = UIGestureRecognizerStatePossible;
}

@end
