//
//  CheckmarkGestureRecognizer.m
//  GestureDemo
//
//  Created by yiqiwang(王一棋) on 2017/8/1.
//  Copyright © 2017年 melody5417. All rights reserved.
//

#import "CheckmarkGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

static int const kToleranceMargin = 5;

@interface CheckmarkGestureRecognizer ()

@property (nonatomic, assign) CheckmarkPhases strokePhase;
@property (nonatomic, assign) CGPoint initialTouchPoint;
@property (nonatomic, strong) UITouch *trackedTouch;

@end

@implementation CheckmarkGestureRecognizer

- (instancetype)init {
    if (self = [super init]) {
        self.strokePhase = CheckmarkPhasesNotStarted;
        self.initialTouchPoint = CGPointZero;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    if (touches.count != 1) {
        self.state = UIGestureRecognizerStateFailed;
    }

    // Capture the first touch and store some information about it.
    if (self.trackedTouch == nil) {
        self.trackedTouch = [touches anyObject];
        self.strokePhase = CheckmarkPhasesInitialPoint;
        self.initialTouchPoint = [self.trackedTouch locationInView:self.view];
    }
    else {
        // Ignore all but the first touch.
        for (UITouch *touch in touches) {
            if (touch != self.trackedTouch) {
                [self ignoreTouch:touch forEvent:event];
            }
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];

    UITouch *newTouch = touches.anyObject;
    if (newTouch != self.trackedTouch) {
        self.state = UIGestureRecognizerStateFailed;
        return ;
    }

    CGPoint newPoint = [newTouch locationInView:self.view];
    CGPoint previousPoint = [newTouch previousLocationInView:self.view];
    if (self.strokePhase == CheckmarkPhasesInitialPoint) {
        // Make sure the initial movement is down and to the right.
        if (newPoint.x >= previousPoint.x
            && newPoint.y >= previousPoint.y) {
            self.strokePhase = CheckmarkPhasesDownStroke;
        }
        else {
            self.state = UIGestureRecognizerStateFailed;
        }
    }
    else if (self.strokePhase == CheckmarkPhasesDownStroke) {
        // Always keep moving left to right.
        if (newPoint.x >= previousPoint.x) {
            // If the y direction changes, the gesture is moving up again.
            // Otherwise, the down stroke continues.
            if (newPoint.y < previousPoint.y) {
                self.strokePhase = CheckmarkPhasesUpStroke;
            }
        }
        else {
            // If the new x value is to the left, the gesture fails.
            self.state = UIGestureRecognizerStateFailed;
        }
    }
    else if (self.strokePhase == CheckmarkPhasesUpStroke) {
        // If the new x value is to the left, or the new y value
        // changed directions again, the gesture fails.
        if (newPoint.x < previousPoint.x
            || newPoint.y > previousPoint.y + kToleranceMargin) {
            self.state = UIGestureRecognizerStateFailed;
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];

    UITouch *newTouch = touches.anyObject;
    if (newTouch != self.trackedTouch) {
        self.state = UIGestureRecognizerStateFailed;
        return ;
    }

    // If the stroke was moving up and the final point is
    // above the initial point, the gesture succeeds.
    CGPoint newPoint = [newTouch locationInView:self.view];
    if (self.state == UIGestureRecognizerStatePossible
        && self.strokePhase == CheckmarkPhasesUpStroke
        && newPoint.y + kToleranceMargin < self.initialTouchPoint.y) {
        self.state = UIGestureRecognizerStateRecognized;
    }
    else {
        self.state = UIGestureRecognizerStateFailed;
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];

    self.initialTouchPoint = CGPointZero;
    self.strokePhase = CheckmarkPhasesNotStarted;
    self.trackedTouch = nil;
    self.state = UITouchPhaseCancelled;
}

- (void)reset {
    [super reset];

    self.initialTouchPoint = CGPointZero;
    self.strokePhase = CheckmarkPhasesNotStarted;
    self.trackedTouch = nil;
}

@end
