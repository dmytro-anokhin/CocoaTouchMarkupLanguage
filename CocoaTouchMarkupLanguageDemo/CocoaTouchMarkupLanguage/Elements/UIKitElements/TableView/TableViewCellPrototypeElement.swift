//
//  TableViewCellPrototypeElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 29/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


class TableViewCellPrototypeElement: ViewPrototypeElement {

    override var elementClass: Element.Type {
        return TableViewCellElement.self
    }

    var cellElement: TableViewCellElement {
        return viewElement as! TableViewCellElement
    }
}
