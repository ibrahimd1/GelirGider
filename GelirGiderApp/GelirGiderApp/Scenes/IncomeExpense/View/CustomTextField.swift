//
//  CustomTextField.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 22.05.2022.
//

import Foundation
import UIKit

internal final class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    internal func configure(with viewModel: CustomTextFieldViewModel) {
        self.attributedPlaceholder = NSAttributedString(
            string: viewModel.placeHolderText,
            attributes: [.foregroundColor: CustomColor.textColorSecondary!, .font: UIFont.Poppins.bold(size: 12).font!]
        )
        self.layer.borderColor =  CustomColor.borderColor?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        self.backgroundColor = CustomColor.backgroundColorComponent
        self.font = .Poppins.regular(size: 12).font
        self.setLeftPaddingPoints(15)
        
        let frame = CGRect(x: 0, y: 0, width: 18 + 15, height: 18)
        let outerView = UIView(frame: frame)
        let iconView  = UIImageView(frame: frame)
        iconView.image = UIImage(named: viewModel.icon)
        iconView.contentMode = .center
        outerView.addSubview(iconView)
        self.rightViewMode = .always
        self.rightView = outerView
        self.keyboardType = viewModel.keyboardType
    }
}

internal struct CustomTextFieldViewModel {
    let placeHolderText: String
    let icon: String
    let keyboardType: UIKeyboardType
}

extension CustomTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(self.keyboardType != .decimalPad){
            return true
        }
        
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        
        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }
        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
    }
}
