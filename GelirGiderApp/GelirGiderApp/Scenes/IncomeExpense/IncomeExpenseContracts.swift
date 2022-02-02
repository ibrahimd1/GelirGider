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
    func addIncome()
    func addExpense()
    func viewSummary(of year: Int)
    func viewAboutTheApp()
}

enum IncomeExpenseViewModelOutput {
    case updateTitle(String)
    case setLoading(Bool)
    case showData(IncomeExpenseType,[IncomeExpensePresentation])
}

protocol IncomeExpenseViewModelDelegate {
    func handleViewModelOutput(_ output: IncomeExpenseViewModelOutput)
}
