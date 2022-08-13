//
//  String+Extension.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 16.04.2022.
//

import UIKit

extension String {
    func width(forHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}
