//
//  ViewPrototypeElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class ViewPrototypeElement: ElementPrototype {

    override var elementClass: Element.Type {
        return ViewElement.self
    }

    var viewElement: ViewElement {
        do {
            return try makeElement() as! ViewElement
        }
        catch {
            fatalError(String(describing: error))
        }
    }
}
