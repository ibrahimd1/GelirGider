//
//  Envirenmont.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 8.10.2023.
//

import Foundation
import UIKit

public enum Environment {
    enum Keys {
        static let appId = "APP_ID"
    }
    
    private static let infoDictionary: [String : Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("pList file not found")
        }
        return dict
    }()
    
    static let appId: String = {
        guard let name = Environment.infoDictionary[Keys.appId] as? String else {
            fatalError("App name not set in pList")
        }
        return name
    }()
}
