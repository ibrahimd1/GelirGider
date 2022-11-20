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
    private var dataList: [IncomeExpenseModel] = []
    
    init() {
        self.realm = try! Realm()
        self.storeManager = StoreManager(realm: self.realm)
    }
    
    func load() {
        delegate?.handleViewModelOutput(.updateHeader("Aylık Özet"))
        
        dataList = storeManager.getAllData()
        if dataList.count > 0 {
            let montlySummaryList = dataList.map { MontlySummaryModel.init(model: $0) }
            let data = montlySummaryList.map { MontlySummaryPresentation.init(model: $0) }
            delegate?.handleViewModelOutput(.showData(data))
        } else {
            delegate?.handleViewModelOutput(.showData([]))
        }
    }
    
    func selectItem(year: Int, month: Int) {
        let viewModel = IncomeExpenseViewModel(isOpenFromAnotherPage: true,year: year, month: month)
        viewModel.year = year
        viewModel.month = month
        delegate?.navigate(to: .detail(viewModel))
    }
}
