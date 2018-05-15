//
//  NavigationControllerElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 01/05/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


public class NavigationControllerElement: Element, PropertyElementType, ViewControllerElementType {

    // MARK: Element

    override public class var factory: ElementsFactoryType {
        return ViewControllerElementsFactory()
    }

    // MARK: Private

    override func instantiate() -> Any? {
        return NavigationController(navigationBarClass: nil, toolbarClass: nil)
    }
}
