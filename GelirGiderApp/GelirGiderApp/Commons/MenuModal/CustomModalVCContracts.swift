//
//  CustomModalVCContracts.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 28.10.2022.
//

import Foundation
import UIKit

internal struct MenuType {
    let image: UIImage
    let title: String
}

internal protocol CustomModalVCDelegate: AnyObject {
    func didSelect(at item: MenuType)
}
