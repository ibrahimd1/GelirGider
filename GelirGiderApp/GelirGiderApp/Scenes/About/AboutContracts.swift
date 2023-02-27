//
//  AboutContracts.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 29.01.2023.
//

import Foundation

protocol AboutViewModelProtocol {
    var delegate: AboutViewModelDelegate? { get set }
    func load()
}

protocol AboutViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: AboutViewModelOutput)
}

enum AboutViewModelOutput {
    case updateHeader(String)
}
