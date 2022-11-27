//
//  YearlySummaryViewModel.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 22.11.2022.
//

import Foundation
import RealmSwift

final class YearlySummaryViewModel: YearlySummaryViewModelProtocol {
    weak var delegate: YearlySummaryViewModelDelegate?
    
    private var storeManager: StoreManager
    private var realm: Realm!
    private var dataList: [IncomeExpenseModel] = []
    private var presentationList: [YearlySummaryPresentation] = []
    
    init() {
        self.realm = try! Realm()
        self.storeManager = StoreManager(realm: realm)
    }
    
    func load() {
        delegate?.handleViewModelOutput(.updateHeader("Yıllık Özet"))
        
        dataList = storeManager.getAllData()
        if dataList.count > 0 {
            var yearList = Array(Set(dataList.map { $0.year }))
            yearList = yearList.sorted(by: { $0 > $1 })
            for year in yearList {
                let modelList = dataList.filter({ $0.year == year })
                let item = sum(year: year, modelList: modelList)
                presentationList.append(item)
            }
        }
        delegate?.handleViewModelOutput(.showData(self.presentationList))
    }
    
    fileprivate func sum(year: Int, modelList: [IncomeExpenseModel]) -> YearlySummaryPresentation {
        var income: Double = 0
        var expense: Double = 0
        var substract: Double = 0
        
        for model in modelList {
            income += model.incomeExpenseList.filter({ $0.type == .income }).map({ $0.amountOfIncomeExpense }).reduce(0, +)
            expense += model.incomeExpenseList.filter({ $0.type == .expense }).map({ $0.amountOfIncomeExpense }).reduce(0, +)
            
            
        }
        substract += income - expense
        
        let result = YearlySummaryPresentation(year: year, income: income, expense: expense, substract: substract)
        return result
    }
}
