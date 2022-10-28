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
        lbl.font = .Poppins.medium(size: 12).font
        lbl.textColor = CustomColor.textColor
        lbl.textAlignment = .center
        return lbl
    }()
    
    internal lazy var lblSubTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.light(size: 9).font
        lbl.textColor = CustomColor.textColor
        lbl.textAlignment = .center
        return lbl
    }()
    
    internal lazy var lblCurrency: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.bold(size: 15).font
        lbl.textColor = CustomColor.textColor
        lbl.text = "30.25₺"
        return lbl
    }()
    
    internal lazy var lblShortcut: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.bold(size: 13).font
        return lbl
    }()
    
    internal var itemIndex: Int? {
        didSet {
            lblShortcut.textColor = CustomColor.itemColorList[(itemIndex ?? 0) % 5]
        }
    }
    
    internal var title: String? {
        didSet {
            lblShortcut.text = getMainLetters(title ?? "")
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = CustomColor.backgroundColor
        let viewCircle = UIView()
        
        viewCircle.addSubview(lblShortcut)
        lblShortcut.translatesAutoresizingMaskIntoConstraints = false
        lblShortcut.centerXAnchor.constraint(equalTo: viewCircle.centerXAnchor).isActive = true
        lblShortcut.centerYAnchor.constraint(equalTo: viewCircle.centerYAnchor).isActive = true
        
        addSubview(viewCircle)
        viewCircle.backgroundColor = CustomColor.cellCircleColor
        viewCircle.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 35, height: 35)
        viewCircle.layer.cornerRadius = 35 / 2
        viewCircle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(lblCurrency)
        lblCurrency.anchor(top: nil, bottom: nil, leading: nil, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        lblCurrency.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let viewTitle = UIView()
        addSubview(viewTitle)
        viewTitle.anchor(top: topAnchor, bottom: bottomAnchor, leading: viewCircle.trailingAnchor, trailing: nil, paddingTop: 15, paddingBottom: -15, paddingTrailing: 0, paddingLeading: 10, width: 0, height: 0)
        
        viewTitle.addSubview(lblTitle)
        lblTitle.anchor(top: viewTitle.topAnchor, bottom: nil, leading: viewTitle.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        
        viewTitle.addSubview(lblSubTitle)
        lblSubTitle.anchor(top: lblTitle.bottomAnchor, bottom: viewTitle.bottomAnchor, leading: viewTitle.leadingAnchor, trailing: viewTitle.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    fileprivate func getMainLetters(_ str: String) -> String {
        if str.count > 0 {
            return str.components(separatedBy: " ").prefix(2).map({ String($0.first!) }).joined(separator: "");
        }
        return ""
    }
}
