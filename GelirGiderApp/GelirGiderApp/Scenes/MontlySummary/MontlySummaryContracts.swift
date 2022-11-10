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
}

enum MontlySummaryViewModelOutput {
    case updateHeader(String)
    case showData([MontlySummaryPresentation])
}
