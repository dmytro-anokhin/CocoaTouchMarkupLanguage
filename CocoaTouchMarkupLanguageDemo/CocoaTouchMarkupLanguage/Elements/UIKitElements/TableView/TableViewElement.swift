//
//  TableViewElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class TableViewElement: ViewElement {

    override class var factory: ElementsFactoryType {
        return TableViewElementsFactory()
    }

    override var viewClass: UIView.Type {
        return objectClass as? UITableView.Type ?? TableView.self
    }

    override func unknownChild(_ child: ElementType, view: UIView) {
        guard let tableView = view as? TableView else {
            assertionFailure("Expected TableView subclass \(view)")
            return
        }

        switch child {
            case let prototypes as TableViewPrototypesElement:
                for case let cellPrototype as TableViewCellPrototypeElement in prototypes.children {
                    addCellPrototype(cellPrototype, tableView: tableView)
                }

            case let cellPrototype as TableViewCellPrototypeElement:
                addCellPrototype(cellPrototype, tableView: tableView)

            default:
                super.unknownChild(child, view: view)
        }
    }

    func addCellPrototype(_ prototype: TableViewCellPrototypeElement, tableView: TableView) {
        tableView.prototypes.append(prototype)
    }
}
