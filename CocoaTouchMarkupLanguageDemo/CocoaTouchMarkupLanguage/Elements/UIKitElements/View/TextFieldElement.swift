//
//  TextFieldElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class TextFieldElement: ViewElement {

    override var viewClass: UIView.Type {
        return objectClass as? UITextField.Type ?? TextField.self
    }
}
