//
//  ImageElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 29/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class ImageElement: Element, PropertyElementType {

    override var instance: Any? {
        guard let name = attributes["name"] else {
            return nil
        }

        return UIImage(named: name)
    }
}
