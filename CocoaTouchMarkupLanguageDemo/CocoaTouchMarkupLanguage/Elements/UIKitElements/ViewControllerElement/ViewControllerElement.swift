//
//  ViewControllerElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


public class ViewControllerElement: Element, PropertyElementType, ViewControllerElementType {

    // MARK: Element

    override public class var factory: ElementsFactoryType {
        return ViewControllerElementsFactory()
    }

    // MARK: Loading

    override func instantiate() -> Any? {
        return ViewController(nibName: nil, bundle: nil)
    }

    override func processChild(_ child: ElementType, instance: Any) {
        guard let viewController = instance as? ViewController else {
            fatalError("Expected \(type(of: ViewController.self)), got: \(instance)")
        }

        switch child {
            case let viewPrototype as ViewPrototypeElement:
                viewController.viewPrototypeElement = viewPrototype

            case let objectController as ObjectControllerElement:
                viewController.objectControllerElement = objectController

            default:
                super.processChild(child, instance: instance)
        }
    }
}
