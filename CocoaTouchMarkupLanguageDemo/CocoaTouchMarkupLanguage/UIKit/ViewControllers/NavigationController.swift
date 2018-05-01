//
//  NavigationController.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 01/05/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class NavigationController: UINavigationController {

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "rootViewController" && viewControllers.isEmpty, let viewController = value as? UIViewController {
            viewControllers = [ viewController ]
            return
        }

        super.setValue(value, forUndefinedKey: key)
    }
}
