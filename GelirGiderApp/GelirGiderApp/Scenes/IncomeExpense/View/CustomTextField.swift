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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    internal func configure(with viewModel: CustomTextFieldViewModel) {
        self.attributedPlaceholder = NSAttributedString(
            string: viewModel.placeHolderText,
            attributes: [.foregroundColor: CustomColor.textColor!, .font: UIFont.boldSystemFont(ofSize:12)]
        )
        self.layer.borderColor = CustomColor.textBoxBorderColor?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        self.font = UIFont.systemFont(ofSize: 12)
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
