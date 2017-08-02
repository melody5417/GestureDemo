//
//  RootViewController.m
//  GestureDemo
//
//  Created by yiqiwang(王一棋) on 2017/7/30.
//  Copyright © 2017年 melody5417. All rights reserved.
//

#import "RootViewController.h"
#import "GesturesDataSource.h"

#import "ViewControllerFactory.h"
#import "SingleGestureViewController.h"

@interface RootViewController () <GesturesDataSourceDelegate>
@property (nonatomic, strong) UITableViewController *tableViewController;
@property (nonatomic, strong) GesturesDataSource *gesturesDataSource;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColorFromRGB(0xD9FAD3);
    
    [self setupNaviagation];
    [self setupTableView];

}

#pragma mark - setup

- (void)setupNaviagation {
    self.navigationItem.title = NSLocalizedString(@"Gestures", nil);
}

- (void)setupTableView {
    self.gesturesDataSource = [[GesturesDataSource alloc] init];
    [self.gesturesDataSource setDelegate:self];

    UITableViewController *tableVC = [[UITableViewController alloc] init];
    [self addChildViewController:tableVC];
    [tableVC.tableView setDelegate:self.gesturesDataSource];
    [tableVC.tableView setDataSource:self.gesturesDataSource];

    tableVC.view.frame = self.view.bounds;
    [self.view addSubview:tableVC.view];
    [tableVC didMoveToParentViewController:self];
}

#pragma mark - GesturesDataSourceDelegate

- (void)gestureDidSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self.gesturesDataSource itemAtAtIndexPath:indexPath];
    Class viewControllerClass = [[ViewControllerFactory new] viewControllerClassWithItem:item];

    UIViewController *viewController = [viewControllerClass new];
    viewController.navigationItem.title = item;
    
    if ([viewController isKindOfClass:[SingleGestureViewController class]]) {
        [(SingleGestureViewController *)viewController setItem:item];
    }

    [self.navigationController pushViewController:viewController animated:NO];
}

@end
