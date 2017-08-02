//
//  ViewControllerFactory.m
//  GestureDemo
//
//  Created by yiqiwang(王一棋) on 2017/8/1.
//  Copyright © 2017年 melody5417. All rights reserved.
//

#import "ViewControllerFactory.h"
#import "SingleGestureViewController.h"
#import "DiscreteCustomGestureViewController.h"
#import "ContinuousCustomGestureViewController.h"
#import "MultiGestureViewController.h"

@implementation ViewControllerFactory

- (Class)viewControllerClassWithItem:(id)item {
    NSArray *singleGestures = @[@"Tap", @"EdgePan", @"LongPress",
                                @"Pan", @"Pinch", @"Rotate",
                                @"Swipe"];

    if ([singleGestures containsObject:item]){
        return [SingleGestureViewController class];
    }
    else if ([item isEqualToString:@"CustomDiscrete"]) {
        return [DiscreteCustomGestureViewController class];
    }
    else if ([item isEqualToString:@"CustomContinuous"]) {
        return [ContinuousCustomGestureViewController class];
    }
    else if ([item isEqualToString:@"MultiGesture"]) {
        return [MultiGestureViewController class];
    }

    return nil;
}

@end
