//
//  DoTryCatch.m
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

#import "DoTryCatch.h"


void objc_do(void (^tryBlock)(void), void (^catchBlock)(NSException *exception)) {
    @try {
        tryBlock();
    }
    @catch (NSException *exception) {
        catchBlock(exception);
    }
}
