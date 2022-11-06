//
//  MainScreenBuilder.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 30.01.2022.
//

import UIKit

final class IncomeExpenseBuilder {
    
    static func make() -> IncomeExpenseViewController {
        let viewController = IncomeExpenseViewController()
        viewController.viewModel = IncomeExpenseViewModel()
        return viewController
    }
}
