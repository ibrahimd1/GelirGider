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
    case income
    case expense
}


enum CustomColor {
    static let backgroundColor = UIColor(named: "BackgroundColor")
    static let backgroundColorBlue = UIColor(named: "BackgroundColorBlue")
    static let backgroundColorComponent = UIColor(named: "BackgroundColorComponent")
    static let textColor = UIColor(named: "TextColor")
    static let textColorSecondary = UIColor(named: "TextColorSecondary")
    static let borderColor = UIColor(named: "BorderColor")
    static let buttonBorderColor = UIColor(named: "ButtonBorderColor")
    static let lineColor = UIColor(named: "LineColor")
    static let footerBackgroundColor = UIColor(named: "FooterBackgroundColor")
    static let cellCircleColor = UIColor(named: "CellCircleColor")
    static let itemColorList = [UIColor(named: "ItemColor1"),UIColor(named: "ItemColor2"),UIColor(named: "ItemColor3"),UIColor(named: "ItemColor4"),UIColor(named: "ItemColor5")]
    static let textColorGreen = UIColor(named: "TextColorGreen")
    static let textColorRed = UIColor(named: "TextColorRed")
    static let seperatorColor = UIColor(named: "SeperatorColor")
}
