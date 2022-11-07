//
//  MontlySummaryCell.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 6.11.2022.
//

import Foundation
import UIKit

final class MontlySummaryCell: UICollectionViewCell {
    
    internal lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.bold(size: 13).font
        lbl.textColor = .white//CustomColor.textColor
        lbl.textAlignment = .center
        lbl.minimumScaleFactor = 0.6
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = CustomColor.backgroundColor
        
        layer.borderWidth = 1
        layer.borderColor = CustomColor.customModalBgColor?.cgColor
        layer.cornerRadius = 17
        
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0))
        
        
        let leftTopView = UIView()
        leftTopView.backgroundColor = UIColor.getRgbColor(red: 52, green: 63, blue: 73)
        leftTopView.layer.cornerRadius = 18
        leftTopView.layer.masksToBounds = true
        leftTopView.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMaxYCorner])
        
        addSubview(leftTopView)
        leftTopView.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 130, height: 20)
        
        leftTopView.addSubview(lblTitle)
        lblTitle.anchor(top: nil, bottom: nil, leading: leftTopView.leadingAnchor, trailing: leftTopView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
