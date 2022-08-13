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
    
    var formattedDateDMY: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy' 'HH:mm:ss"
        return formatter.string(from: self)
    }
}

