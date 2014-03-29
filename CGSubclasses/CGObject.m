//
//  CGObject.m
//  ThisOrThat
//
//  Created by Chase Gorectke on 3/23/14.
//  Copyright (c) 2014 Revision Works, LLC. All rights reserved.
//

#import "CGObject.h"

@interface CGObject ()

@property (nonatomic, assign, readwrite) BOOL offline;

@end

@implementation CGObject
@synthesize offline=_offline;

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    }
    return self;
}

- (void)reachabilityChanged:(NSNotification *)note
{
	CGReachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass:[CGReachability class]]);
	[self updateOffline:curReach];
    [self updateReachability:curReach];
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

- (void)updateReachability:(CGReachability *)reachability
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
