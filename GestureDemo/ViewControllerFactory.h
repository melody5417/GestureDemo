//
//  ViewControllerFactory.h
//  GestureDemo
//
//  Created by yiqiwang(王一棋) on 2017/8/1.
//  Copyright © 2017年 melody5417. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewControllerFactory : NSObject

- (Class)viewControllerClassWithItem:(id)item;

@end
