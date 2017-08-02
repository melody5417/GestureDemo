//
//  ContinuousCustomGestureRecognizer.h
//  GestureDemo
//
//  Created by yiqiwang(王一棋) on 2017/8/1.
//  Copyright © 2017年 melody5417. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContinuousCustomGestureRecognizer : UIGestureRecognizer

@property (nonatomic, assign, readonly) CGPoint currentPosition;

@end
