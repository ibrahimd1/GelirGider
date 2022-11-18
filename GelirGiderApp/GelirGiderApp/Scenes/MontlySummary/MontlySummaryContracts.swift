//
//  MontlySummaryContracts.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 6.11.2022.
//

import Foundation

protocol MontlySummaryViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: MontlySummaryViewModelOutput)
}

protocol MontlySummaryViewModelProtocol {
    var delegate: MontlySummaryViewModelDelegate? { get set }
    func load()
    func didSelect(year: Int, data: [IncomeExpenseModel]?)
}

enum MontlySummaryViewModelOutput {
    case updateHeader(String)
    case showData([MontlySummaryPresentation])
    case setPickerViewData([String])
    case updateYearText(String)
}
