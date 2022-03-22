//
//  IncomeExpensePresentation.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 2.02.2022.
//

import UIKit

internal struct IncomeExpensePresentation {
    let id: String
    let year: Int
    let month: Int
    let itemList: [IncomeExpenseItemPresentation]
    
    init(model: IncomeExpenseModel) {
        self.id = model.id
        self.year = model.year
        self.month = model.month
        self.itemList = model.incomeExpenseList.map(IncomeExpenseItemPresentation.init)
    }
}

struct IncomeExpenseItemPresentation {
    let itemId: String
    let type: IncomeExpenseType
    let description: String
    let dateTime: Date
    let amount: Double
    
    init(id: String, type: IncomeExpenseType, description: String, dateTime: Date, amount: Double) {
        self.itemId = id
        self.type = type
        self.description = description
        self.dateTime = dateTime
        self.amount = amount
    }
}


extension IncomeExpenseItemPresentation {
    init(model: IncomeExpenseItemModel) {
        self.itemId = model.itemId
        self.type = model.type
        self.description = model.descriptionOfIncomeExpense
        self.dateTime = model.timeOfIncomeExpense
        self.amount = model.amountOfIncomeExpense
    }
}
