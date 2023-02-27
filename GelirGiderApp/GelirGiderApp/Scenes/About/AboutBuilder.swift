//
//  AboutBuilder.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 29.01.2023.
//

import Foundation

final class AboutBuilder {
    static func make(with viewModel: AboutViewModelProtocol) -> AboutViewController {
        let vc = AboutViewController()
        vc.viewModel = viewModel
        return vc
    }
}
