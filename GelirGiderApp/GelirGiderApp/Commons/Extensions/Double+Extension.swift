//
//  Double+Extension.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 13.08.2022.
//

import Foundation

extension Double {
    internal var stringValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        return formatter.string(from: self as NSNumber)!
    }
}
