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
    func addIncomeExpense(type: IncomeExpenseType, description: String, amount: Double, index: Int)
    func updateIncomeExpense(with id: String, description: String?, amount: Double?, index: Int)
    func deleteIncomeExpense(with id: String, index: Int)
}

enum IncomeExpenseViewModelOutput {
    case updateHeader(year: Int, month: String)
    case showData(IncomeExpensePresentation)
    case showNewItem(type: IncomeExpenseType,IncomeExpensePresentation)
    case setSummary(incomeSum: Double, expenseSum: Double, substractSum: Double)
}

protocol IncomeExpenseViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: IncomeExpenseViewModelOutput)
}

enum SummaryViewType {
    case income
    case expense
    case substract
}
