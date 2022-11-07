//
//  IncomeExpenseContracts.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 2.02.2022.
//

import Foundation

protocol IncomeExpenseViewModelProtocol {
    var delegate: IncomeExpenseViewModelDelegate? {get set}
    func load()
    func addIncomeExpense(type: IncomeExpenseType, description: String, amount: Double)
    func updateIncomeExpense(with id: String, description: String?, amount: Double?, index: Int)
    func deleteIncomeExpense(with id: String, type: IncomeExpenseType, index: Int)
    func selectItem(at type: MenuType)
}

enum IncomeExpenseViewModelOutput {
    case updateHeader(year: Int, month: String)
    case showData(IncomeExpensePresentation)
    case showNewItem(type: IncomeExpenseType,IncomeExpensePresentation)
    case setSummary(incomeSum: Double, expenseSum: Double, substractSum: Double)
    case deleteItem(type: IncomeExpenseType,index: Int,IncomeExpensePresentation)
}

protocol IncomeExpenseViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: IncomeExpenseViewModelOutput)
    func navigate(to route: IncomeExpenseRoute)
}

enum IncomeExpenseRoute {
    case montlySummary(MontlySummaryViewModelProtocol)
}
