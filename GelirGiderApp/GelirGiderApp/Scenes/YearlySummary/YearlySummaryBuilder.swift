//
//  YearlySummaryBuilder.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 22.11.2022.
//

import Foundation

final class YearlySummaryBuilder {
    static func make(with viewModel: YearlySummaryViewModelProtocol) -> YearlySummaryViewController {
        let vc = YearlySummaryViewController()
        vc.viewModel = viewModel
        return vc
    }
}
