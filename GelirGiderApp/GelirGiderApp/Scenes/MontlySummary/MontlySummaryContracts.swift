//
//  MontlySummaryContracts.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 6.11.2022.
//

import Foundation

protocol MontlySummaryViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: MontlySummaryViewModelOutput)
    func navigate(to route: MontlySummaryRoute)
}

protocol MontlySummaryViewModelProtocol {
    var delegate: MontlySummaryViewModelDelegate? { get set }
    func load()
    func selectItem(year: Int, month: Int)
}

enum MontlySummaryViewModelOutput {
    case updateHeader(String)
    case showData([MontlySummaryPresentation])
}

enum MontlySummaryRoute {
    case detail(IncomeExpenseViewModelProtocol)
}
