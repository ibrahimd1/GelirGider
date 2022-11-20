//
//  MainScreenBuilder.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 30.01.2022.
//

import UIKit

final class IncomeExpenseBuilder {    
    static func make(with viewModel: IncomeExpenseViewModelProtocol?) -> IncomeExpenseViewController {
        let viewController = IncomeExpenseViewController()
        if viewModel != nil {
            viewController.viewModel = viewModel
        } else {
            viewController.viewModel = IncomeExpenseViewModel(year: nil, month: nil)
        }
        return viewController
    }
}
