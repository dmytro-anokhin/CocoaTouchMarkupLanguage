//
//  ViewControllerElementType.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 14/05/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


public protocol ViewControllerElementType {

    var viewController: UIViewController { get }
}


public extension ViewControllerElementType where Self: Element {

    var viewController: UIViewController {
        return instance as! UIViewController
    }
}
