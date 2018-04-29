//
//  TableView.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class TableView: UITableView, UITableViewDataSource, UITableViewDelegate {

    var prototypes: [TableViewCellPrototypeElement] = []

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        init_TableView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        init_TableView()
    }

    private func init_TableView() {
        dataSource = self
        delegate = self

        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = 44.0
    }

    @objc var rows: NSArray? {
        didSet {
            reloadData()
        }
    }

    private var cellToElementMap: [UITableViewCell: TableViewCellElement] = [:]

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let row = rows![indexPath.row] as! (NSObject & NSMutableCopying)

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell ?? {
            let element = prototypes.first!.cellElement
            element.reuseIdentifier = "Cell"

            let cell = element.cell as! TableViewCell
            cellToElementMap[cell] = element

            return cell
        }()

        let element = cellToElementMap[cell]!
        cell.representedObject = ObjectController(row)
        cell.bindingTokens = connect(viewElement: element, objectController: cell.representedObject!)

        return cell
    }
//
//    // MARK: UITableViewDelegate
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
////        (cell.representedObject as ObjectController)?["number"] = "Hello, world!"
//    }
}
