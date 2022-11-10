//
//  MontlySummaryModel.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 10.11.2022.
//

import Foundation

internal struct MontlySummaryModel {
    let year: Int
    let month: Int
    let incomeSum: Double
    let expenseSum: Double
    let substractSum: Double
}

extension MontlySummaryModel {
    init(model: IncomeExpenseModel) {
        self.year = model.year
        self.month = model.month
        self.incomeSum = model.incomeExpenseList.filter({ $0.type == .income }).map({$0.amountOfIncomeExpense}).reduce(0, +)
        self.expenseSum = model.incomeExpenseList.filter({ $0.type == .expense }).map({$0.amountOfIncomeExpense}).reduce(0, +)
        self.substractSum = self.incomeSum - self.expenseSum
    }
}
