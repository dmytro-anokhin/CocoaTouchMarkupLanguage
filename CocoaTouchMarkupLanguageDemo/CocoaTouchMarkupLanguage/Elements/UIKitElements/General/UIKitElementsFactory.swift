//
//  UIKitElementsFactory.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


class UIKitElementsFactory: ElementsFactory {

    override func element(for xmlNode: XMLNode) throws -> ElementType {
        switch xmlNode.name {
            case "color":
                return try ColorElement(from: xmlNode)

            case "font":
                return try FontElement(from: xmlNode)


            case "viewController":
                return try ViewControllerElement(from: xmlNode)

            case "navigationController":
                return try NavigationControllerElement(from: xmlNode)


            case "view":
                return try ViewElement(from: xmlNode)

            case "scrollView":
                return try ScrollViewElement(from: xmlNode)

            case "tableView":
                return try TableViewElement(from: xmlNode)

            case "stackView":
                return try StackViewElement(from: xmlNode)

            case "textField":
                return try TextFieldElement(from: xmlNode)


            case "action":
                return try ActionElement(from: xmlNode)


            default:
                return try super.element(for: xmlNode)
        }
    }
}
