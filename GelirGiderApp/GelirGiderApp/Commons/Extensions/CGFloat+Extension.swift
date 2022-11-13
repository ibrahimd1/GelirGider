//
//  CGFloat+Extension.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 13.11.2022.
//

import Foundation

extension CGFloat {
    internal var stringValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        return formatter.string(from: self as NSNumber)!
    }
}
