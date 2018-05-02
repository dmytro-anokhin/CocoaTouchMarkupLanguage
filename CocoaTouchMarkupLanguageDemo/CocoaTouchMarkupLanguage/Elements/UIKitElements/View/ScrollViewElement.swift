//
//  ScrollViewElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 01/05/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import Foundation


class ScrollViewElement: ViewElement {

    override var viewClass: UIView.Type {
        return objectClass as? UIScrollView.Type ?? ScrollView.self
    }
}
