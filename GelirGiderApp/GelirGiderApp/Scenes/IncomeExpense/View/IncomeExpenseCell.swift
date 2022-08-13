//
//  IncomeCell.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 12.04.2022.
//

import Foundation
import UIKit

internal class IncomeExpenseCell: UITableViewCell {
    
    internal lazy var imgIcon: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 10
        return img
    }()
    
    internal lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 9)
        lbl.textColor = CustomColor.textColor
        return lbl
    }()
    
    internal lazy var lblSubTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 8)
        lbl.textColor = CustomColor.textColor
        return lbl
    }()
    
    internal lazy var lblCurrency: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 10)
        lbl.textColor = CustomColor.textColor
        lbl.text = "30.25₺"
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = CustomColor.backgroundColor
        
        addSubview(imgIcon)
        imgIcon.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 20, height: 20)
        imgIcon.translatesAutoresizingMaskIntoConstraints = false
        imgIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(lblCurrency)
        lblCurrency.anchor(top: nil, bottom: nil, leading: nil, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        lblCurrency.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(lblTitle)
        lblTitle.anchor(top: topAnchor, bottom: nil, leading: imgIcon.trailingAnchor, trailing: nil, paddingTop: 10, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 10, width: 0, height: 0)

        addSubview(lblSubTitle)
        lblSubTitle.anchor(top: lblTitle.bottomAnchor, bottom: bottomAnchor, leading: imgIcon.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -10, paddingTrailing: 0, paddingLeading: 10, width: 0, height: 0)
        
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 30, y: 50, width: contentView.frame.size.width, height: 1.0)
        bottomBorder.backgroundColor = CustomColor.lineColor?.cgColor
        contentView.layer.addSublayer(bottomBorder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
