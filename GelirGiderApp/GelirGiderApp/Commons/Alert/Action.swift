//
//  Action.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 12.11.2022.
//

import Foundation
import UIKit

enum ActionStyle {
    case normal
    case destructive
    case destructiveDark
    case normalDark
}

class Action {
    var title: String
    var style: ActionStyle
    var actionHandler: () -> Void

    init(with title: String, style: ActionStyle = .normal, actionHandler: @escaping () -> Void) {
        self.title = title
        self.style = style
        self.actionHandler = actionHandler
    }
}
