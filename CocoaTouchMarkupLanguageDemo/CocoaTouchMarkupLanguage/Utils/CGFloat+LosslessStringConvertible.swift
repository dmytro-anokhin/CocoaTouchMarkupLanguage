//
//  CGFloat+LosslessStringConvertible.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import CoreGraphics


extension CGFloat : LosslessStringConvertible {

    public init?<S>(_ text: S) where S : StringProtocol {
        guard let double = Double(text) else {
            return nil
        }

        self = CGFloat(double)
    }
}
