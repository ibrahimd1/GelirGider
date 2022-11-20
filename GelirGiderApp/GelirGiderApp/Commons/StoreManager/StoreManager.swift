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
        //print("Path:",Realm.Configuration.defaultConfiguration.fileURL)
        let list = realm.object(ofType: IncomeExpenseModel.self, forPrimaryKey: getPrimaryKey(year, month))
        return list
    }
    
    internal func addItem(type: IncomeExpenseType, description: String, amount: Double, date: Date) -> IncomeExpenseModel {
        let list = realm.object(ofType: IncomeExpenseModel.self, forPrimaryKey: getPrimaryKey(self.currentYear, self.currentMonth))
        let listItem = IncomeExpenseItemModel(type: type, desc: description, dateTime: date, amount: amount)
        
        if let tempList = list {
            try! realm.write {
                tempList.incomeExpenseList.append(listItem)
            }
        } else {
            let tempList = List<IncomeExpenseItemModel>()
            tempList.append(listItem)
            try! realm.write {
                let value: IncomeExpenseModel = IncomeExpenseModel(year: self.currentYear, month: self.currentMonth, incomeExpenseList: tempList)
                realm.create(IncomeExpenseModel.self, value: value)
            }
        }
        
        let object = realm.object(ofType: IncomeExpenseModel.self, forPrimaryKey: getPrimaryKey(self.currentYear, self.currentMonth))!
        return object
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
    
    internal func deleteItem(with id: String) -> IncomeExpenseModel {
        let list = realm.object(ofType: IncomeExpenseModel.self, forPrimaryKey: getPrimaryKey(self.currentYear, self.currentMonth))
        let item = list!.incomeExpenseList.where {
            $0.itemId == id
        }
        let indexOfItem = list!.incomeExpenseList.index(of: item[0])
        try! realm.write {
            list!.incomeExpenseList.remove(at: indexOfItem!)
        }
        return list!
    }
    
    internal func getAllData() -> [IncomeExpenseModel] {
        let list = realm.objects(IncomeExpenseModel.self)
        return Array(list)
    }
    
    fileprivate func getPrimaryKey(_ year: Int, _ month: Int) -> String {
        return "\(year)\(month)"
    }
    
    //TESTTTTTTTTTTTTTTT
    internal func addItemTest(type: IncomeExpenseType, description: String, amount: Double, date: Date, year:Int, month: Int) {
        let list = realm.object(ofType: IncomeExpenseModel.self, forPrimaryKey: getPrimaryKey(year, month))
        let listItem = IncomeExpenseItemModel(type: type, desc: description, dateTime: date, amount: amount)
        
        if let tempList = list {
            try! realm.write {
                tempList.incomeExpenseList.append(listItem)
            }
        } else {
            let tempList = List<IncomeExpenseItemModel>()
            tempList.append(listItem)
            try! realm.write {
                let value: IncomeExpenseModel = IncomeExpenseModel(year: year, month: month, incomeExpenseList: tempList)
                realm.create(IncomeExpenseModel.self, value: value)
            }
        }
    }
}
