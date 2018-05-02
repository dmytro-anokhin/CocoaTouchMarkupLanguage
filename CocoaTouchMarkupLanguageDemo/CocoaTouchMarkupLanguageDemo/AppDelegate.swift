//
//  AppDelegate.swift
//  CocoaTouchMarkupLanguageDemo
//
//  Created by Dmytro Anokhin on 26/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit
import CocoaTouchMarkupLanguage


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let parser = Parser(url: Bundle.main.url(forResource: "InitialViewController", withExtension: "xml")!)

        parser.parse { xmlNode in
            guard let xmlNode = xmlNode else {
                return
            }

            do {
                let element = try NavigationControllerElement(from: xmlNode)
                self.window?.rootViewController = element.navigationController
            }
            catch {
                print(error)
            }
        }

        window?.makeKeyAndVisible()

        return true
    }
}
