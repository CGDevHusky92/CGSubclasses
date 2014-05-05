//
//  CGMutableArray.m
//  CGSubclasses
//
//  Created by Chase Gorectke on 4/27/14.
//  Copyright (c) 2014 Revision Works, LLC. All rights reserved.
//

#import "NSMutableArray+GRID.h"

@implementation NSMutableArray (GRID)

+ (NSMutableArray *)mutableArrayWithDimensions:(NSString *)dimensions
{
    NSMutableArray *returnArray = nil;
    NSRange bitRange;
    if ((bitRange = [dimensions rangeOfString:@"^\\[\\d+]" options:NSRegularExpressionSearch]).location != NSNotFound) {
        NSUInteger size = [[dimensions substringWithRange:NSMakeRange(1, bitRange.length - 2)] integerValue];
        if (dimensions.length == bitRange.length) {
            returnArray = [self mutableNullArrayWithSize:size];
        } else {
            returnArray = [[NSMutableArray alloc] initWithCapacity:size];
            NSString *nextLevel = [dimensions substringWithRange:NSMakeRange(bitRange.length, dimensions.length - bitRange.length)];
            NSMutableArray *subArray;
            for (int i = 0; i < size; i++) {
                subArray = [self mutableArrayWithDimensions:nextLevel];
                if (subArray) {
                    [returnArray addObject:subArray];
                } else { return nil; }
            }
        }
    } else { return nil; }
    return returnArray;
}

+ (NSMutableArray *)mutableNullArrayWithSize:(NSUInteger)size
{
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:size];
    for (int i = 0; i < size; i++)
        [returnArray addObject:[NSNull null]];
    return returnArray;
}

@end
