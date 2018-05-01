//
//  AppDelegate.swift
//  CocoaTouchMarkupLanguageDemo
//
//  Created by Dmytro Anokhin on 26/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit
import CocoaTouchMarkupLanguage


class EntrypointViewController: UITableViewController {

    let entries: [String] = {
        let urls = Bundle.main.urls(forResourcesWithExtension: "xml", subdirectory: nil)!

        return urls.map { url in
            return url.deletingPathExtension().lastPathComponent
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentViewControllerElement = nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = entries[indexPath.row]
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let parser = Parser(url: Bundle.main.url(forResource: entries[indexPath.row], withExtension: "xml")!)

        parser.parse { xmlNode in
            var builder = ViewControllerBuilder()
            builder.xmlNode = xmlNode

            do {
                self.navigationController?.pushViewController(try builder.build(), animated: true)
            }
            catch {
                print(error)
            }
        }
    }
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let viewController = EntrypointViewController(style: .plain)
        let navigationController = UINavigationController(rootViewController: viewController)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
