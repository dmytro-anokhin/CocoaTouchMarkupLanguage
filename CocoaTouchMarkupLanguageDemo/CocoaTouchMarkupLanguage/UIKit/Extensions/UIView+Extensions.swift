//
//  UIView+Extensions.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 29/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


// MARK: - UIViewController

extension UIView {

    var viewController: UIViewController? {
        var responder: UIResponder? = self

        while responder != nil {
            if let viewController = responder as? UIViewController {
                return viewController
            }

            responder = responder?.next
        }

        return nil
    }

    func targetViewController(forAction action: Selector, sender: Any?) -> UIViewController? {
        return viewController?.targetViewController(forAction: action, sender: sender)
    }
}


// MARK: - Width and Height constraints

let widthIdentifier = "CocoaTouchMarkupLanguage.Width"
let heightIdentifier = "CocoaTouchMarkupLanguage.Height"


extension UIView {

    @objc var width: CGFloat {
        get {
            return constraint(withIdentifier: widthIdentifier, affectingLayoutFor: .horizontal, relation: .equal)?.constant ?? 0.0
        }

        set {
            deactivateConstraint(withIdentifier: widthIdentifier, affectingLayoutFor: .horizontal, relation: .lessThanOrEqual)
            deactivateConstraint(withIdentifier: widthIdentifier, affectingLayoutFor: .horizontal, relation: .equal)
            deactivateConstraint(withIdentifier: widthIdentifier, affectingLayoutFor: .horizontal, relation: .greaterThanOrEqual)
            activateConstraint(withIdentifier: widthIdentifier, affectingLayoutFor: .horizontal, relation: .equal, constant: newValue)
        }
    }

    @objc var minWidth: CGFloat {
        get {
            return constraint(withIdentifier: widthIdentifier, affectingLayoutFor: .horizontal, relation: .greaterThanOrEqual)?.constant ?? 0.0
        }

        set {
            deactivateConstraint(withIdentifier: widthIdentifier, affectingLayoutFor: .horizontal, relation: .greaterThanOrEqual)
            deactivateConstraint(withIdentifier: widthIdentifier, affectingLayoutFor: .horizontal, relation: .equal)
            activateConstraint(withIdentifier: widthIdentifier, affectingLayoutFor: .horizontal, relation: .greaterThanOrEqual, constant: newValue)
        }
    }

    @objc var maxWidth: CGFloat {
        get {
            return constraint(withIdentifier: widthIdentifier, affectingLayoutFor: .horizontal, relation: .lessThanOrEqual)?.constant ?? 0.0
        }

        set {
            deactivateConstraint(withIdentifier: widthIdentifier, affectingLayoutFor: .horizontal, relation: .lessThanOrEqual)
            deactivateConstraint(withIdentifier: widthIdentifier, affectingLayoutFor: .horizontal, relation: .equal)
            activateConstraint(withIdentifier: widthIdentifier, affectingLayoutFor: .horizontal, relation: .lessThanOrEqual, constant: newValue)
        }
    }

    @objc var height: CGFloat {
        get {
            return constraint(withIdentifier: heightIdentifier, affectingLayoutFor: .vertical, relation: .equal)?.constant ?? 0.0
        }

        set {
            deactivateConstraint(withIdentifier: heightIdentifier, affectingLayoutFor: .vertical, relation: .lessThanOrEqual)
            deactivateConstraint(withIdentifier: heightIdentifier, affectingLayoutFor: .vertical, relation: .equal)
            deactivateConstraint(withIdentifier: heightIdentifier, affectingLayoutFor: .vertical, relation: .greaterThanOrEqual)
            activateConstraint(withIdentifier: heightIdentifier, affectingLayoutFor: .vertical, relation: .equal, constant: newValue)
        }
    }

    @objc var minHeight: CGFloat {
        get {
            return constraint(withIdentifier: heightIdentifier, affectingLayoutFor: .vertical, relation: .greaterThanOrEqual)?.constant ?? 0.0
        }

        set {
            deactivateConstraint(withIdentifier: heightIdentifier, affectingLayoutFor: .vertical, relation: .greaterThanOrEqual)
            deactivateConstraint(withIdentifier: heightIdentifier, affectingLayoutFor: .vertical, relation: .equal)
            activateConstraint(withIdentifier: heightIdentifier, affectingLayoutFor: .vertical, relation: .greaterThanOrEqual, constant: newValue)
        }
    }

    @objc var maxHeight: CGFloat {
        get {
            return constraint(withIdentifier: heightIdentifier, affectingLayoutFor: .vertical, relation: .lessThanOrEqual)?.constant ?? 0.0
        }

        set {
            deactivateConstraint(withIdentifier: heightIdentifier, affectingLayoutFor: .vertical, relation: .lessThanOrEqual)
            deactivateConstraint(withIdentifier: heightIdentifier, affectingLayoutFor: .vertical, relation: .equal)
            activateConstraint(withIdentifier: heightIdentifier, affectingLayoutFor: .vertical, relation: .lessThanOrEqual, constant: newValue)
        }
    }

    private func deactivateConstraint(withIdentifier identifier: String, affectingLayoutFor axis: UILayoutConstraintAxis, relation: NSLayoutRelation) {
        constraint(withIdentifier: identifier, affectingLayoutFor: axis, relation: relation)?.isActive = false
    }

    private func activateConstraint(withIdentifier identifier: String, affectingLayoutFor axis: UILayoutConstraintAxis, relation: NSLayoutRelation, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: self, attribute: axis == .horizontal ? .width : .height, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: constant)
        constraint.priority = UILayoutPriority.required - 1.0
        constraint.isActive = true
    }

    private func constraint(withIdentifier identifier: String, affectingLayoutFor axis: UILayoutConstraintAxis, relation: NSLayoutRelation? = nil) -> NSLayoutConstraint? {
        return constraintsAffectingLayout(for: axis).filter({
            if let relation = relation {
                return $0.identifier == identifier && $0.relation == relation
            }

            return $0.identifier == identifier
        }).first
    }
}
