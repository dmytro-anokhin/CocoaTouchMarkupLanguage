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

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        let element = cellToElementMap[cell]!

        for case let action as ActionElement in element.children {
            guard let objectController = cell.representedObject else {
                assertionFailure("Object controller is required to perform an action")
                return
            }

            let allArguments = argumentsDictionary(for: action, objectController: objectController)
            let arguments = allArguments.filter { !$0.0.hasPrefix("CTML") }

            guard let viewControllerName = allArguments["CTMLViewControllerName"] as? String else {
                assertionFailure("View controller is required to perform an action")
                return
            }

            guard let url = Bundle.main.url(forResource: viewControllerName, withExtension: "xml") else {
                assertionFailure("View controller \(viewControllerName) not found in the main bundle")
                return
            }

            let parser = Parser(url: url)

            parser.parse { xmlNode in
                var builder = ViewControllerBuilder()
                builder.xmlNode = xmlNode
                builder.arguments = arguments

                do {
                    let viewController = try builder.build()

                    if let targetViewController = self.targetViewController(forAction: #selector(UIViewController.show(_:sender:)), sender: self) {
                        targetViewController.show(viewController, sender: self)
                    }
                }
                catch {
                    print(error)
                }
            }

            break
        }
    }
}
