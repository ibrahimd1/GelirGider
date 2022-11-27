//
//  YearlySummaryContracts.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 22.11.2022.
//

import Foundation

protocol YearlySummaryViewModelProtocol {
    var delegate: YearlySummaryViewModelDelegate? { get set }
    func load()
}

protocol YearlySummaryViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: YearlySummaryViewModelOutput)
}

enum YearlySummaryViewModelOutput {
    case updateHeader(String)
    case showData([YearlySummaryPresentation])
}
