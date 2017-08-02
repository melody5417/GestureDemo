//
//  GesturesDataSource.h
//  GestureDemo
//
//  Created by yiqiwang(王一棋) on 2017/7/30.
//  Copyright © 2017年 melody5417. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol GesturesDataSourceDelegate <NSObject>

- (void)gestureDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface GesturesDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<GesturesDataSourceDelegate> delegate;

- (id)itemAtAtIndexPath:(NSIndexPath *)indexPath;

@end
