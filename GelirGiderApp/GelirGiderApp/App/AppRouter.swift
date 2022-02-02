//
//  AppRouter.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 30.01.2022.
//

import UIKit

final class AppRouter {
    let window : UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start() {
        let viewController = IncomeExpenseBuilder.make()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
