//
//  IncomeExpenseViewModel.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 2.02.2022.
//

import Foundation
import RealmSwift

final class IncomeExpenseViewModel: IncomeExpenseViewModelProtocol {
    weak var delegate: IncomeExpenseViewModelDelegate?
    private var incomeExpenseData: IncomeExpenseModel = IncomeExpenseModel()
    private var storeManager: StoreManager
    private var realm: Realm!
    
    init(){
        self.realm = try! Realm()
        storeManager = StoreManager(realm: self.realm)
    }
    
    func load() {
        let today = Date()
        delegate?.handleViewModelOutput(.updateHeader(year: today.currentYear, month: today.currentMonthName))
        
        let data: IncomeExpenseModel? = storeManager.getData(of: today.currentMonth, in: today.currentYear)
        guard let data = data else { return }
        incomeExpenseData = data
        delegate?.handleViewModelOutput(.showData(IncomeExpensePresentation.init(model: incomeExpenseData)))
        setSummary()
    }
    
    func addIncomeExpense(type: IncomeExpenseType, description: String, amount: Double) {
        let result: IncomeExpenseModel = storeManager.addItem(type: type, description: description, amount: amount, date: Date())
        incomeExpenseData = result
        delegate?.handleViewModelOutput(.showNewItem(type: type, IncomeExpensePresentation.init(model: incomeExpenseData)))
        setSummary()
    }
    
    func updateIncomeExpense(with id: String, description: String?, amount: Double?, index: Int) {
        
    }
    
    func deleteIncomeExpense(with id: String, type: IncomeExpenseType, index: Int) {
        let data = storeManager.deleteItem(with: id)
        incomeExpenseData = data
        delegate?.handleViewModelOutput(.deleteItem(type: type, index: index, IncomeExpensePresentation.init(model: incomeExpenseData)))
        setSummary()
    }
    
    fileprivate func setSummary(){
        let incomeSum = incomeExpenseData.incomeExpenseList.filter({ $0.type == .income }).map({$0.amountOfIncomeExpense}).reduce(0, +)
        let expenseSum = incomeExpenseData.incomeExpenseList.filter({ $0.type == .expense }).map({$0.amountOfIncomeExpense}).reduce(0, +)
        let substractSum = incomeSum - expenseSum
        
        delegate?.handleViewModelOutput(.setSummary(incomeSum: incomeSum, expenseSum: expenseSum, substractSum: substractSum))
    }
}
