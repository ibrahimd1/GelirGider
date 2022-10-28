//
//  UIFont+Extension.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 25.10.2022.
//

import Foundation
import UIKit

extension UIFont {
    enum Poppins{
        case light(size: CGFloat)
        case regular(size: CGFloat)
        case medium(size: CGFloat)
        case semiBold(size: CGFloat)
        case bold(size: CGFloat)
        
        var font: UIFont! {
            switch self {
            case .light(let size):
                return UIFont(name: "Poppins-Light", size: size)
            case .regular(let size):
                return UIFont(name: "Poppins-Regular", size: size)
            case .medium(let size):
                return UIFont(name: "Poppins-Medium", size: size)
            case .semiBold(let size):
                return UIFont(name: "Poppins-SemiBold", size: size)
            case .bold(let size):
                return UIFont(name: "Poppins-Bold", size: size)
            }
        }
    }
}
