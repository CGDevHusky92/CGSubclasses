//
//  CGViewController.m
//  ThisOrThat
//
//  Created by Chase Gorectke on 3/23/14.
//  Copyright (c) 2014 Revision Works, LLC. All rights reserved.
//

#import "CGViewController.h"

@interface CGViewController ()

@property (nonatomic, assign, readwrite) BOOL offline;

@end

@implementation CGViewController
@synthesize offline=_offline;

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    [super viewDidLoad];
}

- (void)reachabilityChanged:(NSNotification *)note
{
	CGReachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass:[CGReachability class]]);
    [self updateOffline:curReach];
	[self updateInterfaceWithReachability:curReach];
}

- (void)updateOffline:(CGReachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    if (netStatus == NotReachable) {
        _offline = true;
    } else {
        _offline = false;
    }
}

- (void)updateInterfaceWithReachability:(CGReachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    if (netStatus == NotReachable) {
        NSLog(@"Network unreachable.");
    } else if (netStatus == ReachableViaWiFi) {
        NSLog(@"Network reachable via wifi.");
    } else if (netStatus == ReachableViaWWAN) {
        NSLog(@"Network reachable via wwan.");
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

@end
