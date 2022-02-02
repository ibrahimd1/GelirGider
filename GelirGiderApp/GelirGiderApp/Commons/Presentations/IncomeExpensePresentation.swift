//
//  IncomeExpensePresentation.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 2.02.2022.
//

import UIKit

struct IncomeExpensePresentation {
    let description: String
    let dateTime: Date
    let amount: Double
    
    init(description: String, dateTime: Date, amount: Double) {
        self.description = description
        self.dateTime = dateTime
        self.amount = amount
    }
}


extension IncomeExpensePresentation {
    init(obj: IncomeExpenseModel) {
        self.description = obj.descriptionOfIncomeExpense
        self.dateTime = obj.timeOfIncomeExpense
        self.amount = obj.amountOfIncomeExpense
    }
}
