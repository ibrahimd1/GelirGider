//
//  IncomeExpenseViewModel.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 2.02.2022.
//

import Foundation

final class IncomeExpenseViewModel: IncomeExpenseViewModelProtocol {
    var delegate: IncomeExpenseViewModelDelegate?
    
    func load(year: Int, month: Int) {
        
    }
    
    func addIncomeExpense(type: IncomeExpenseType, description: String, amount: Double, index: Int) {
        
    }
    
    func updateIncomeExpense(with id: String, description: String?, amount: Double?, index: Int) {
        
    }
    
    func deleteIncomeExpense(with id: String, index: Int) {
        
    }    
}
