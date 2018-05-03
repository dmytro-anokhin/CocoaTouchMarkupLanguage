//
//  TableViewCell.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 29/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


class TableViewCell: UITableViewCell, ContainerViewType {

    @objc var managedView: UIView? {
        get {
            return containerView.managedView
        }

        set {
            containerView.managedView = newValue
        }
    }

    var horizontalAlignment: ContainerViewAlignment {
        get {
            return containerView.horizontalAlignment
        }

        set {
            containerView.horizontalAlignment = newValue
        }
    }

    var verticalAlignment: ContainerViewAlignment {
        get {
            return containerView.verticalAlignment
        }

        set {
            containerView.verticalAlignment = newValue
        }
    }

    var relativeToMargins: Bool {
        get {
            return containerView.relativeToMargins
        }

        set {
            containerView.relativeToMargins = newValue
        }
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if set(value: value, forKey: key) {
            // noop
        }
        else {
            super.setValue(value, forUndefinedKey: key)
        }
    }

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    private let containerView: ContainerView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        containerView = ContainerView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)

        let constraints = [
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]

        for constraint in constraints {
            constraint.priority = UILayoutPriority.required - 1.0 // Prevent broken constraints with self sizing cells when real size is not yet calculated
        }

        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder aDecoder: NSCoder) { // Not supported
        fatalError("init(coder:) has not been implemented")
    }

    var representedObject: ObjectController?

    var bindingTokens: [ObservationTokenType]? {
        willSet {
            guard let objectController = representedObject,
                  let tokens = bindingTokens
            else {
                return
            }

            disconnect(view: self, objectController: objectController, tokens: tokens)
        }
    }
}
