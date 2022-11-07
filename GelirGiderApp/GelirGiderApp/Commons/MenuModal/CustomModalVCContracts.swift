//
//  CustomModalVCContracts.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 28.10.2022.
//

import Foundation
import UIKit

internal struct MenuObject {
    let image: UIImage
    let title: String
}

internal enum MenuType {
    case montlySummary
    case about
    case appStore
}

internal protocol CustomModalVCDelegate: AnyObject {
    func didSelect(at item: MenuType)
}
