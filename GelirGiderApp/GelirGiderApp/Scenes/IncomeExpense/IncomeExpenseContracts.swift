//
//  IncomeExpenseContracts.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 2.02.2022.
//

import Foundation

protocol IncomeExpenseViewModelProtocol {
    var delegate: IncomeExpenseViewModelDelegate? {get set}
    func load(year: Int, month: Int)
    func addIncomeExpense(type: IncomeExpenseType, description: String, amount: Double, index: Int)
    func updateIncomeExpense(with id: String, description: String?, amount: Double?, index: Int)
    func deleteIncomeExpense(with id: String, index: Int)
}

enum IncomeExpenseViewModelOutput {
    case updateTitle(String)
    case showData([IncomeExpensePresentation],[IncomeExpensePresentation])
    case showNewItem(type: IncomeExpenseType,IncomeExpensePresentation)
    case reloadItem(Int)
}

protocol IncomeExpenseViewModelDelegate {
    func handleViewModelOutput(_ output: IncomeExpenseViewModelOutput)
}

enum SummaryViewType {
    case income
    case expense
    case substract
}
