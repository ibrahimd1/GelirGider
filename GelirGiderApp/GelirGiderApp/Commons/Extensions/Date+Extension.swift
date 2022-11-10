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
    
    var currentMonthName: String {
        get {
            let now = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "tr")
            dateFormatter.dateFormat = "LLLL"
            return dateFormatter.string(from: now)
        }
    }
    
    var formattedDateDMY: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy' 'HH:mm"
        return formatter.string(from: self)
    }
    
    static func getMonthName(month: Int) -> String {
        return monthNames[month - 1]
    }
}

