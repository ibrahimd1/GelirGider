//
//  CustomModalTableViewCell.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 28.10.2022.
//

import Foundation
import UIKit

internal final class CustomModalTableViewCell: UITableViewCell {
    internal lazy var leftIcon: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    internal lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.medium(size: 15).font
        lbl.textColor = CustomColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = CustomColor.customModalBgColor
        clipsToBounds = true
        layer.masksToBounds = true
        addSubview(leftIcon)
        addSubview(lblTitle)
        
        leftIcon.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 25, width: 0, height: 0)
        
        lblTitle.anchor(top: topAnchor, bottom: bottomAnchor, leading: leftIcon.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 16, width: 0, height: 0)
        lblTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
