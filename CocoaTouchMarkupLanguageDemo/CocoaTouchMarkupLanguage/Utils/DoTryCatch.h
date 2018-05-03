//
//  DoTryCatch.h
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

@import Foundation;


NS_ASSUME_NONNULL_BEGIN


extern inline void objc_do(void (^tryBlock)(void), void (^catchBlock)(NSException *exception)) NS_SWIFT_NAME(objc_do(try:catch:));


NS_ASSUME_NONNULL_END
