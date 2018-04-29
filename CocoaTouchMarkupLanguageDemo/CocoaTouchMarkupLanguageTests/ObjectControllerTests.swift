//
//  ObjectControllerTests.swift
//  CocoaTouchMarkupLanguageTests
//
//  Created by Dmytro Anokhin on 26/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import XCTest
@testable import CocoaTouchMarkupLanguage


class ObjectControllerTests: XCTestCase {

    func testJSONArray() {
        let data = Data(bundleResource: "CityNames.json")

        do {
            let objectController = try ObjectController.json(data)
            XCTAssert(objectController is ArrayController)

            let arrayController = objectController as! ArrayController
            let expectedData = [ "Amsterdam", "Kyiv", "Stockholm", "Paris", "Berlin", "Hong Kong", "Tokyo", "New York", "London", "Shanghai", "Toronto" ]
            XCTAssertEqual(arrayController.count, expectedData.count)
            XCTAssertEqual(arrayController.arrangedObjects as! [String], expectedData)

            for i in 0..<expectedData.count {
                XCTAssertEqual(arrayController[i] as! String, expectedData[i])
            }
        }
        catch {
            preconditionFailure(String(describing: error))
        }
    }

    func testJSONObject() {
        let data = Data(bundleResource: "Amsterdam.json")

        do {
            let objectController = try ObjectController.json(data)
            XCTAssertEqual(objectController.value(forKey: "name") as! String, "Amsterdam")
        }
        catch {
            preconditionFailure(String(describing: error))
        }
    }

    func testSimpleObserving() {
        let expectation = self.expectation(description: "foo")
        let controller = ObjectController()
        let observation = controller.observe("foo") { controller, keyPath in
            XCTAssertEqual(keyPath, "foo")
            XCTAssertEqual(controller.value(forKey: keyPath) as! String, "FOO")
            expectation.fulfill()
        }

        controller.setValue("FOO", forKey: "foo")
        waitForExpectations(timeout: 0.1, handler: nil)
        controller.remove(observation: observation)
    }

    func testKeyPathObserving() {
        let expectation = self.expectation(description: "foo.bar")
        let controller = ObjectController()

        var count = 0

        let observation = controller.observe("foo.bar") { controller, keyPath in
            count += 1
            XCTAssertEqual(keyPath, "foo.bar")

            // The value changes two times, first when empty container set, second is actual string
            switch count {
                case 1:
                    XCTAssertNil(controller.value(forKey: keyPath))
                case 2:
                    XCTAssertEqual(controller.value(forKey: keyPath) as! String, "FOO")
                    expectation.fulfill()
                default:
                    break
            }
        }

        controller.setValue(NSMutableDictionary(), forKey: "foo")
        controller.setValue("FOO", forKey: "foo.bar")

        waitForExpectations(timeout: 0.1, handler: nil)
        controller.remove(observation: observation)
    }
}
