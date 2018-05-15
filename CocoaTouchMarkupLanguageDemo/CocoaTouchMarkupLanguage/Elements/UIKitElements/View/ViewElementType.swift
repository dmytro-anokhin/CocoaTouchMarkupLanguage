//
//  ViewElementType.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 14/05/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


public protocol ViewElementType {

    var view: UIView { get }
}


public extension ViewElementType where Self: Element {

    var view: UIView {
        return instance as! UIView
    }
}
