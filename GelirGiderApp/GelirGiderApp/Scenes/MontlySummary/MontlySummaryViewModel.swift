//+
//  MontlySummaryViewModel.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 6.11.2022.
//

import Foundation
import RealmSwift

final class MontlySummaryViewModel: MontlySummaryViewModelProtocol {
    weak var delegate: MontlySummaryViewModelDelegate?
    private var storeManager: StoreManager
    private var realm: Realm!
    private var yearList: [String] = []
    private var dataList: [IncomeExpenseModel] = []
    
    init() {
        self.realm = try! Realm()
        self.storeManager = StoreManager(realm: self.realm)
    }
    
    func load() {
        delegate?.handleViewModelOutput(.updateHeader("Aylık Özet"))
        
        let lastYear = getYears()
        didSelect(year: lastYear, data: dataList)
        delegate?.handleViewModelOutput(.setPickerViewData(yearList))
    }
    
    func selectItem() {
        
    }
    
    func didSelect(year: Int, data: [IncomeExpenseModel]?) {
        var localData: [IncomeExpenseModel]?
        if let dataList = data {
            localData = dataList
        } else {
            localData = storeManager.getAllData(in: year)
        }
        
        if let result = localData {
            let montlySummaryList = result.map { MontlySummaryModel.init(model: $0) }
            let data = montlySummaryList.map { MontlySummaryPresentation.init(model: $0) }
            delegate?.handleViewModelOutput(.showData(data))
        } else {
            delegate?.handleViewModelOutput(.showData([]))
        }
    }
    
    fileprivate func getYears() -> Int {
        let today = Date()
        guard let data = storeManager.getAllData(in: -1) else { return today.currentYear}
        dataList = data
        var years: [Int] = []
        
        for item in dataList {
            if !years.contains(item.year) {
                years.append(item.year)
            }
        }
        years = years.sorted(by: {$0 > $1})
        
        for year in years {
            yearList.append("\(year)")
        }
        
        guard let first = years.first else { return today.currentYear }
        return Int(first)
    }
}
