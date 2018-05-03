//
//  ContainerViewType.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 03/05/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


/// A protocol for a view that manages layout of another view.
protocol ContainerViewType: NSObjectProtocol {

    /// The view managed by the container view.
    var managedView: UIView? { get set }

    /// The alignment specifies how the managed view aligned inside the container by x axis
    var horizontalAlignment: ContainerViewAlignment { get set }

    /// The alignment specifies how the managed view aligned inside the container by y axis
    var verticalAlignment: ContainerViewAlignment { get set }

    /// Specifies if layout margins included or excluded when positioning the managed view
    var relativeToMargins: Bool { get set }
}
