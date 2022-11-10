//
//  MontlySummaryPresentation.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 7.11.2022.
//

import Foundation

internal struct MontlySummaryPresentation {
    let year: Int
    let month: Int
    let income: Double
    let expense: Double
    let substract: Double
}

extension MontlySummaryPresentation {
    init(model: MontlySummaryModel) {
        self.year = model.year
        self.month = model.month
        self.income = model.incomeSum
        self.expense = model.expenseSum
        self.substract = model.substractSum
    }
}
