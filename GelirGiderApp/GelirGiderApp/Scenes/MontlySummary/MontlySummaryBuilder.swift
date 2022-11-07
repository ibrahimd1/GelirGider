//
//  MontlySummaryBuilder.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 6.11.2022.
//

import Foundation

final class MontlySummaryBuilder {
    static func make(with viewMdel: MontlySummaryViewModelProtocol) -> MontlySummaryViewController {
        let vc = MontlySummaryViewController()
        vc.viewModel = viewMdel
        return vc
    }
}
