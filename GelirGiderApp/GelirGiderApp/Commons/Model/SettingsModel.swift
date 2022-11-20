//
//  SettingsModel.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 20.11.2022.
//

import Foundation
import RealmSwift

internal final class SettingsModel: Object {
    @Persisted var incomeExpenseOptions: IncomeExpenseType
    
    convenience init(incomeExpenseOptions: IncomeExpenseType) {
        self.init()
        self.incomeExpenseOptions = incomeExpenseOptions
    }
}
