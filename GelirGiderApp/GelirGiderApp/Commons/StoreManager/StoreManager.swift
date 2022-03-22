//
//  StoreManager.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 13.03.2022.
//

import Foundation
import RealmSwift

internal final class StoreManager {
    
    let realm: Realm!
    let currentDate = Date()
    let currentYear: Int
    let currentMonth: Int
    
    init(realm: Realm) {
        self.realm = realm
        self.currentYear = currentDate.currentYear
        self.currentMonth = currentDate.currentMonth
    }
    
    internal func getData(of month: Int, in year: Int) -> IncomeExpenseModel? {
        let list = realm.object(ofType: IncomeExpenseModel.self, forPrimaryKey: getPrimaryKey(year, month))
        return list
    }
    
    internal func addItem(type: IncomeExpenseType, description: String, amount: Double, date: Date) -> Bool {
        let list = realm.object(ofType: IncomeExpenseModel.self, forPrimaryKey: getPrimaryKey(self.currentYear, self.currentMonth))
        guard let list = list else { return false }
        
        let item = IncomeExpenseItemModel(type: type, desc: description, dateTime: date, amount: amount)
        try! realm.write {
            list.incomeExpenseList.append(item)
        }
        return true
    }
    
    internal func updateItem(with id: String, description: String, amount: Double) -> Bool {
        let list = realm.object(ofType: IncomeExpenseModel.self, forPrimaryKey: getPrimaryKey(self.currentYear, self.currentMonth))
        guard let list = list else { return false }
        
        try! realm.write {
            let item = list.incomeExpenseList.where {
                $0.itemId == id
            }
            item[0].descriptionOfIncomeExpense = description
            item[0].amountOfIncomeExpense = amount
        }
        return true
    }
    
    internal func deleteItem(with id: String) -> Bool {
        let list = realm.object(ofType: IncomeExpenseModel.self, forPrimaryKey: getPrimaryKey(self.currentYear, self.currentMonth))
        guard let list = list else { return false }
        
        let item = list.incomeExpenseList.where {
            $0.itemId == id
        }
        
        guard let indexOfItem = item.index(of: item[0]) else { return false }
        
        try! realm.write {
            list.incomeExpenseList.remove(at: indexOfItem)
        }
        return true
    }
    
    fileprivate func getPrimaryKey(_ year: Int, _ month: Int) -> String {
        return "\(year)\(month)"
    }
}
