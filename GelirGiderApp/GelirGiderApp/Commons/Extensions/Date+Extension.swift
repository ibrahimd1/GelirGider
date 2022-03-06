//
//  Date+Extension.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 2.02.2022.
//

import Foundation

extension Date {
    var currentYear: Int {
        Calendar.current.component(.year, from: self)
    }
    
    var currentMonth: Int {
        Calendar.current.component(.month, from: self)
    }
}

