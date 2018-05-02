//
//  LabelElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 02/05/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class LabelElement: ViewElement {

    override var viewClass: UIView.Type {
        return objectClass as? UILabel.Type ?? Label.self
    }

    override func loadView() -> UIView {
        let view = super.loadView()
        view.isOpaque = true

        return view
    }
}
