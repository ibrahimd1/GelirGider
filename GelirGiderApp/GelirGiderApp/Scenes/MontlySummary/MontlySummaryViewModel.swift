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
    
    init() {
        self.realm = try! Realm()
        self.storeManager = StoreManager(realm: self.realm)
    }
    
    func load() {
        delegate?.handleViewModelOutput(.updateHeader("Aylık Özet"))
        
        let result = storeManager.getAllData()
        guard let result = result else { return }
        let montlySummaryList = result.map { MontlySummaryModel.init(model: $0) }
        let data = montlySummaryList.map { MontlySummaryPresentation.init(model: $0) }
        delegate?.handleViewModelOutput(.showData(data))
    }
    
    func selectItem() {
        
    }
}
