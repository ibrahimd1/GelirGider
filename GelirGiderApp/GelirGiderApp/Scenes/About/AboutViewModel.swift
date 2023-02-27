//
//  AboutViewModel.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 29.01.2023.
//

import Foundation

final class AboutViewModel: AboutViewModelProtocol {
    weak var delegate: AboutViewModelDelegate?
    
    func load() {
        delegate?.handleViewModelOutput(.updateHeader("Hakkında"))
    }
}
