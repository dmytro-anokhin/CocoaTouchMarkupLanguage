//
//  ContainerView.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class ContainerView: UIView, ContainerViewType, ContentViewAlignable {

    // MARK: ContainerViewType

    var managedView: UIView? {
        willSet{
            managedView?.removeFromSuperview()
        }

        didSet {
            guard let managedView = managedView else {
                return
            }

            managedView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(managedView)
        }
    }

    var relativeToMargins: Bool = false {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    var relativeToReadableContent: Bool = false {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    var relativeToSafeArea: Bool = false {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    // MARK: ContentViewAlignable

    var horizontalAlignment: ContainerViewAlignment = .default {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    var verticalAlignment: ContainerViewAlignment = .default {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    // MARK: NSKeyValueCoding

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if !set(value: value, forKey: key) {
            super.setValue(value, forUndefinedKey: key)
        }
    }

    // MARK: UIConstraintBasedLayoutCoreMethods

    private var currentConstraints: [NSLayoutConstraint]?

    override func updateConstraints() {
        super.updateConstraints()

        if let constraints = currentConstraints {
            NSLayoutConstraint.deactivate(constraints)
            currentConstraints = nil
        }

        guard let managedView = managedView else {
            return
        }


        let layoutItem: LayoutConstraintCreation

        if relativeToReadableContent {
            layoutItem = readableContentGuide
        }
        else if relativeToSafeArea {
            layoutItem = safeAreaLayoutGuide
        }
        else if relativeToMargins {
            layoutItem = layoutMarginsGuide
        }
        else {
            layoutItem = self
        }

        var constraints: [NSLayoutConstraint] = []

        // TODO: Will center anchor work?

        switch horizontalAlignment {
            case .center:
                constraints += [
                    managedView.leadingAnchor.constraint(greaterThanOrEqualTo: layoutItem.leadingAnchor, constant: 0.0),
                    managedView.trailingAnchor.constraint(lessThanOrEqualTo: layoutItem.trailingAnchor, constant: 0.0),
                    managedView.centerXAnchor.constraint(equalTo: centerXAnchor)
                ]
            case .leading:
                constraints += [
                    managedView.leadingAnchor.constraint(equalTo: layoutItem.leadingAnchor, constant: 0.0),
                    managedView.trailingAnchor.constraint(lessThanOrEqualTo: layoutItem.trailingAnchor, constant: 0.0)
                ]
            case .trailing:
                constraints += [
                    managedView.leadingAnchor.constraint(greaterThanOrEqualTo: layoutItem.leadingAnchor, constant: 0.0),
                    managedView.trailingAnchor.constraint(equalTo: layoutItem.trailingAnchor, constant: 0.0)
                ]
        }

        switch verticalAlignment {
            case .center:
                constraints += [
                    managedView.topAnchor.constraint(greaterThanOrEqualTo: layoutItem.topAnchor, constant: 0.0),
                    managedView.bottomAnchor.constraint(lessThanOrEqualTo: layoutItem.bottomAnchor, constant: 0.0),
                    managedView.centerYAnchor.constraint(equalTo: centerYAnchor)
                ]
            case .leading:
                constraints += [
                    managedView.topAnchor.constraint(equalTo: layoutItem.topAnchor, constant: 0.0),
                    managedView.bottomAnchor.constraint(lessThanOrEqualTo: layoutItem.bottomAnchor, constant: 0.0)
                ]
            case .trailing:
                constraints += [
                    managedView.topAnchor.constraint(greaterThanOrEqualTo: layoutItem.topAnchor, constant: 0.0),
                    managedView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0)
                ]
        }

        NSLayoutConstraint.activate(constraints)
        currentConstraints = constraints
    }
}
