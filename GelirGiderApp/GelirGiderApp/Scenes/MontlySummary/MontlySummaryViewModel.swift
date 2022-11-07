//
//  MontlySummaryViewModel.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 6.11.2022.
//

import Foundation

final class MontlySummaryViewModel: MontlySummaryViewModelProtocol {
    var delegate: MontlySummaryViewModelDelegate?
    
    func load() {
        delegate?.handleViewModelOutput(.updateHeader("Aylık Özet"))
    }
    
    func selectItem() {
        
    }
}
