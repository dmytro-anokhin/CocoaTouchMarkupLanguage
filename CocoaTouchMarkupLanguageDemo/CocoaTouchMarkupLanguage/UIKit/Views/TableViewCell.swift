//
//  TableViewCell.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 29/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


class TableViewCell: UITableViewCell {

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    private var currentConstraints: [NSLayoutConstraint]?

    private var stackView: UIStackView?

    func addArrangedSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false

        if stackView == nil {
            stackView = UIStackView()
            stackView?.axis = .vertical
            stackView?.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(stackView!)
        }

        stackView?.addArrangedSubview(view)
    }

    override func updateConstraints() {
        super.updateConstraints()

        if let constraints = currentConstraints {
            NSLayoutConstraint.deactivate(constraints)
            currentConstraints = nil
        }

        guard let stackView = stackView else {
            return
        }

        let margins = layoutMargins

        let constraints = [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margins.top),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margins.left),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -1.0 * margins.bottom),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -1.0 * margins.right)
        ]

        NSLayoutConstraint.activate(constraints)
        currentConstraints = constraints
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
