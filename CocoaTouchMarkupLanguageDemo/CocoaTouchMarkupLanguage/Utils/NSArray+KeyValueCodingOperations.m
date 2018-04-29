//
//  NSArray+KeyValueCodingOperations.m
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 29/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

#import "NSArray+KeyValueCodingOperations.h"


@implementation NSArray (KeyValueCodingOperations)

- (id)_firstForKeyPath:(NSString *)keyPath
{
    NSArray *array = [self valueForKey:keyPath];

    if (![array isKindOfClass:[NSArray class]]) {
        return nil;
    }

    return [array firstObject];
}

@end
