//
//  IncomeExpenseViewModel.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 2.02.2022.
//

import Foundation
import RealmSwift

final class IncomeExpenseViewModel: IncomeExpenseViewModelProtocol {
    var year: Int
    var month: Int
    var isOpenFromAnotherPage: Bool    
    weak var delegate: IncomeExpenseViewModelDelegate?
    private var incomeExpenseData: IncomeExpenseModel = IncomeExpenseModel()
    private var storeManager: StoreManager
    private var realm: Realm!
    
    init(isOpenFromAnotherPage: Bool = false, year: Int?, month: Int?){
        let today = Date()
        self.realm = try! Realm()
        storeManager = StoreManager(realm: self.realm)
        self.isOpenFromAnotherPage = isOpenFromAnotherPage
        self.year = year ?? today.currentYear
        self.month = month ?? today.currentMonth
    }
    
    func load() {
        delegate?.handleViewModelOutput(.updateHeader(year: year, month: Date.getMonthName(month: month)))
        delegate?.handleViewModelOutput(.showData)
        setSummary()
        setOptions()
    }
    
    func getData() {
        let data: IncomeExpenseModel? = storeManager.getData(of: month, in: year)
        guard let data = data else { return }
        incomeExpenseData = data
        delegate?.handleViewModelOutput(.setData(IncomeExpensePresentation.init(model: incomeExpenseData)))
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
    
    func selectItem(at type: MenuType) {
        switch type {
        case .yearlySummary:
            let viewModel = YearlySummaryViewModel()
            delegate?.navigate(to: .yearlySummary(viewModel))
        case .montlySummary:
            let viewModel = MontlySummaryViewModel()
            delegate?.navigate(to: .montlySummary(viewModel))
        case .about:
            let viewModel = AboutViewModel()
            delegate?.navigate(to: .about(viewModel))
            break
        case .appStore:
            delegate?.navigate(to: .rateAndReviewOnAppstore)
            break
        }
    }
    
    func selectIncomeExpenseButton(type: IncomeExpenseType) {
        storeManager.addOptions(type: type)
    }
    
    fileprivate func setSummary(){
        let incomeSum = incomeExpenseData.incomeExpenseList.filter({ $0.type == .income }).map({$0.amountOfIncomeExpense}).reduce(0, +)
        let expenseSum = incomeExpenseData.incomeExpenseList.filter({ $0.type == .expense }).map({$0.amountOfIncomeExpense}).reduce(0, +)
        let substractSum = incomeSum - expenseSum
        
        delegate?.handleViewModelOutput(.setSummary(incomeSum: incomeSum, expenseSum: expenseSum, substractSum: substractSum))
    }
    
    fileprivate func setOptions() {
        guard !isOpenFromAnotherPage else { return }
        let options = storeManager.getOptions()
        if options.count > 0 {
            delegate?.handleViewModelOutput(.selectSegment(type: options[0].incomeExpenseOptions))
        }
    }
}
