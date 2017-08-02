//
//  GesturesDataSource.m
//  GestureDemo
//
//  Created by yiqiwang(王一棋) on 2017/7/30.
//  Copyright © 2017年 melody5417. All rights reserved.
//

#import "GesturesDataSource.h"

@interface GesturesDataSource ()

@property (nonatomic, strong) NSArray *items;

@end

@implementation GesturesDataSource

- (instancetype)init {
    if (self = [super init]) {
        self.items = [[NSArray alloc] initWithObjects:
                      @"Tap",
                      @"EdgePan",
                      @"LongPress",
                      @"Pan",
                      @"Pinch",
                      @"Rotate",
                      @"Swipe",
                      @"CustomDiscrete",
                      @"CustomContinuous",
                      @"MultiGesture", nil];
    }
    return self;
}

#pragma mark - public

- (id)itemAtAtIndexPath:(NSIndexPath *)indexPath {
    return [self.items objectAtIndex:indexPath.row];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.delegate && [self.delegate respondsToSelector:@selector(gestureDidSelectRowAtIndexPath:)]) {
        [self.delegate gestureDidSelectRowAtIndexPath:indexPath];
    }

}

@end
