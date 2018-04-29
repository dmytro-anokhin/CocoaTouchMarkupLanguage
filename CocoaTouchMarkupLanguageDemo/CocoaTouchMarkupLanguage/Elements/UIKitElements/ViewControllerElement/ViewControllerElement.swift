//
//  ViewControllerElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


public class ViewControllerElement: Element {

    override public class var factory: ElementsFactoryType {
        return ViewControllerElementsFactory()
    }

    public lazy var viewController: UIViewController = {
        let viewController = ViewController(nibName: nil, bundle: nil)

        viewController.viewPrototypeElement = children.first { $0 is ViewPrototypeElement } as? ViewPrototypeElement
        viewController.objectControllerElement = children.first { $0 is ObjectControllerElement } as? ObjectControllerElement

        return viewController
    }()
}
