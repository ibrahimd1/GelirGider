//
//  IncomeExpenseModel.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 2.02.2022.
//

import UIKit
import RealmSwift

internal final class IncomeExpenseModel: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var year: Int
    @Persisted var month: Int
    @Persisted var incomeExpenseList: List<IncomeExpenseItemModel>
    
    convenience init(year: Int, month: Int, incomeExpenseList: List<IncomeExpenseItemModel>) {
        self.init()
        self.year = year
        self.month = month
        self.incomeExpenseList = incomeExpenseList
        self.id = getPrimaryKey()
    }
    
    fileprivate func getPrimaryKey() -> String {
        return "\(self.year)\(self.month)"
    }
}

internal final class IncomeExpenseItemModel: Object {
    @Persisted(primaryKey: true) var itemId: String = UUID().uuidString
    @Persisted var type: IncomeExpenseType
    @Persisted var descriptionOfIncomeExpense: String
    @Persisted var timeOfIncomeExpense: Date
    @Persisted var amountOfIncomeExpense: Double
    
    convenience init(type: IncomeExpenseType, desc: String, dateTime: Date, amount: Double) {
        self.init()
        self.type = type
        self.descriptionOfIncomeExpense = desc
        self.timeOfIncomeExpense = dateTime
        self.amountOfIncomeExpense = amount
    }
}
