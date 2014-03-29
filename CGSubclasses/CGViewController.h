//
//  CGViewController.h
//  ThisOrThat
//
//  Created by Chase Gorectke on 3/23/14.
//  Copyright (c) 2014 Revision Works, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGReachability.h"

@interface CGViewController : UIViewController

- (void)updateInterfaceWithReachability:(CGReachability *)reachability;

@property (nonatomic, assign, readonly) BOOL offline;

@end
