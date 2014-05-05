//
//  CGObject.h
//  ThisOrThat
//
//  Created by Chase Gorectke on 3/23/14.
//  Copyright (c) 2014 Revision Works, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CGReachability/CGReachability.h>

@interface CGObject : NSObject

- (void)updateReachabilityStatus:(CGReachability *)reachability;

@property (nonatomic, assign, readonly) BOOL offline;

@end
