//
//  AppDelegate.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 8.03.2021.
//

import UIKit
import CoreData


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
 
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        if #available(iOS 13, *) {
            // do nothing in AppDelegate
        } else {
            let toDoListView = ToDoListRouter.createModule()
            let navigationController = UINavigationController()
            navigationController.viewControllers = [toDoListView]
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.backgroundColor = .white
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }

      
        return true
    }

    
    
}

