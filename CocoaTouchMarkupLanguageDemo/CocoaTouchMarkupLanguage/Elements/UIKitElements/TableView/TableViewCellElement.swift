//
//  TableViewCellElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 29/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class TableViewCellElement: ViewElement {

    override var viewClass: UIView.Type {
        return objectClass as? UITableViewCell.Type ?? TableViewCell.self
    }

    var cell: UITableViewCell {
        return view as! UITableViewCell
    }

    var reuseIdentifier: String?

    override func instantiate() -> Any? {
        guard let cellClass = viewClass as? UITableViewCell.Type else {
            fatalError("Expected \(type(of: UITableViewCell.self)), got \(viewClass)")
        }

        return cellClass.init(style: .default, reuseIdentifier: reuseIdentifier)
    }

    override func addSubview(_ subview: ViewElement, view: UIView) {
        guard let cell = view as? UITableViewCell else {
            fatalError("Expected \(type(of: UITableViewCell.self)), got \(view)")
        }

        cell.contentView.addSubview(subview.view)
    }
}
