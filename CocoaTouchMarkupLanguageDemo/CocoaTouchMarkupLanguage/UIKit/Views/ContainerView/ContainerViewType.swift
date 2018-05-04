//
//  ContainerViewType.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 03/05/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


/// A protocol for a view that manages layout of another view.
protocol ContainerViewType: class {

    /// The view managed by the container view.
    var managedView: UIView? { get set }

    /// Specifies if layout margins included or excluded when positioning the managed view
    var relativeToMargins: Bool { get set }

    /// Specifies if the managed view is constrained to the readable content
    var relativeToReadableContent: Bool { get set }

    /// Specifies if the managed view is constrained to the safe area
    var relativeToSafeArea: Bool { get set }
}


protocol ContentViewAlignable: class {

    /// The alignment specifies how the managed view aligned inside the container by x axis
    var horizontalAlignment: ContainerViewAlignment { get set }

    /// The alignment specifies how the managed view aligned inside the container by y axis
    var verticalAlignment: ContainerViewAlignment { get set }
}


extension ContainerViewType {

    func set(value: Any?, forKey key: String) -> Bool {
        return self.set_ContainerViewType(value: value, forKey: key)
    }

    /// Sets the protocol property value for the corresponding key. Returns true if the property for the key exists.
    fileprivate func set_ContainerViewType(value: Any?, forKey key: String) -> Bool {
        switch key {
            case "managedView":
                managedView = value as? UIView
                return true

            case "relativeToMargins":
                relativeToMargins = (value as? NSString)?.boolValue ?? false
                return true

            case "relativeToReadableContent":
                relativeToReadableContent = (value as? NSString)?.boolValue ?? false
                return true

            case "relativeToSafeArea":
                relativeToSafeArea = (value as? NSString)?.boolValue ?? false
                return true

            default:
                return false
        }
    }
}


extension ContainerViewType where Self: ContentViewAlignable {

    func set(value: Any?, forKey key: String) -> Bool {
        if self.set_ContentViewAlignable(value: value, forKey: key) {
            return true
        }

        return set_ContainerViewType(value: value, forKey: key)
    }
}


extension ContentViewAlignable {

    /// Sets the protocol property value for the corresponding key. Returns true if the property for the key exists.
    fileprivate func set_ContentViewAlignable(value: Any?, forKey key: String) -> Bool {
        switch key {
            case "alignment":
                if let value = value as? String {
                    let alignment = ContainerViewAlignment(string: value)
                    self.horizontalAlignment = alignment
                    self.verticalAlignment = alignment
                }
                else {
                    self.horizontalAlignment = .default
                    self.verticalAlignment = .default
                }

                return true

            case "horizontalAlignment":
                if let value = value as? String {
                    self.horizontalAlignment = ContainerViewAlignment(string: value)
                }
                else {
                    self.horizontalAlignment = .default
                }

                return true

            case "verticalAlignment":
                if let value = value as? String {
                    self.verticalAlignment = ContainerViewAlignment(string: value)
                }
                else {
                    self.verticalAlignment = .default
                }

                return true

            default:
                return false
        }
    }
}
