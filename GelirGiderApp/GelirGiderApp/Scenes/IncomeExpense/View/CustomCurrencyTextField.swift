//
//  CustomCurrencyTextField.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 16.09.2023.
//

import Foundation
import UIKit

internal final class CustomCurrencyTextField: CustomTextField {
    var amt = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTextField() -> String {
        let number = Double(amt / 100) + Double(amt%100) / 100
        return number.stringValue
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = self.text ?? "0"
        let currentAmt = Int(text.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: ".", with: "")) ?? 0
        amt = currentAmt
        if let digit = Int(string) {
            amt = amt * 10 + digit
            self.text = updateTextField()
        }
        
        if string == "" {
            amt = amt / 10
            self.text = amt == 0 ? "" : updateTextField()
        }
        return false
    }
}
