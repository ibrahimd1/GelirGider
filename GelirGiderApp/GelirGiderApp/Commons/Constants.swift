//
//  Constants.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 2.02.2022.
//

import Foundation
import RealmSwift
import UIKit

enum IncomeExpenseType: String,PersistableEnum {
    case Income
    case Expense
}


enum CustomColor {
    static let backgroundColor = UIColor(named: "BackgroundColor")
    static let backgroundColorBlue = UIColor(named: "BackgroundColorBlue")
    static let backgroundColorGreen = UIColor(named: "BackgroundColorGreen")
    static let backgroundColorRed = UIColor(named: "BackgroundColorRed")
    static let backgroundColorSecondary = UIColor(named: "BackgroundColorSecondary")
    static let primaryGreen = UIColor(named: "PrimaryGreen")
    static let primaryRed = UIColor(named: "PrimaryRed")
    static let secondaryGreen = UIColor(named: "SecondaryGreen")
    static let secondaryRed = UIColor(named: "SecondaryRed")
    static let textColor = UIColor(named: "TextColor")
}
