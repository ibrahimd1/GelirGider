//
//  CustomSegmentedControl.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 16.10.2022.
//

import Foundation
import UIKit

internal final class CustomSegmentedControl: UISegmentedControl{
    private let segmentInset: CGFloat = 5
    private let segmentImage: UIImage? = UIImage(color: CustomColor.backgroundColorComponent!)
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
        let textAttributesSelected = [NSAttributedString.Key.foregroundColor : CustomColor.textColor!, NSAttributedString.Key.font : UIFont.Poppins.semiBold(size: 14).font!]
        let textAttributesNormal = [NSAttributedString.Key.foregroundColor : CustomColor.textColorSecondary!, NSAttributedString.Key.font : UIFont.Poppins.semiBold(size: 14).font!]
        
        self.setTitleTextAttributes(textAttributesNormal, for: .normal)
        self.setTitleTextAttributes(textAttributesSelected, for: .selected)
        self.layer.borderColor = CustomColor.borderColor?.cgColor
        self.layer.borderWidth = 1
        
        //background
        layer.cornerRadius = bounds.height/2
        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView
        {
            foregroundImageView.bounds = foregroundImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            foregroundImageView.image = segmentImage
            foregroundImageView.layer.removeAnimation(forKey: "SelectionBounds")
            foregroundImageView.layer.masksToBounds = true
            foregroundImageView.layer.cornerRadius = foregroundImageView.bounds.height/2
        }
    }
}

extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
