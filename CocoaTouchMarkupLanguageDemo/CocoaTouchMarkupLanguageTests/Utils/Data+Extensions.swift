//
//  Data+Extensions.swift
//  CocoaTouchMarkupLanguageTests
//
//  Created by Dmytro Anokhin on 26/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import Foundation


extension Data {

    init(bundleResource: String) {
        let bundle = Bundle(for: ObjectControllerTests.self)
        let url = bundle.url(forResource: bundleResource.components(separatedBy: ".").first!,
            withExtension: bundleResource.components(separatedBy: ".").last!)
        precondition(url != nil, "Resource \(bundleResource) not in the bundle \(bundle)")

        do {
            self = try Data(contentsOf: url!)
        }
        catch {
            preconditionFailure(String(describing: error))
        }
    }
}
