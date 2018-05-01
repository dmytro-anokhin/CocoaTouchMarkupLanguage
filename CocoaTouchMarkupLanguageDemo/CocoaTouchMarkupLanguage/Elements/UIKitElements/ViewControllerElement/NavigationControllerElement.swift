//
//  NavigationControllerElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 01/05/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


public class NavigationControllerElement: Element, PropertyElementType {

    var value: Any? {
        return navigationController
    }

    override public class var factory: ElementsFactoryType {
        return ViewControllerElementsFactory()
    }

    public lazy var navigationController: UINavigationController = {
        let navigationController = NavigationController(navigationBarClass: nil, toolbarClass: nil)

        for child in children {
            switch child {
                case let property as ElementType & PropertyElementType:
                    setProperty(property, object: navigationController)

                default:
                    //unknownChild(child, view: view)
                    break
            }
        }

        return navigationController
    }()
}
