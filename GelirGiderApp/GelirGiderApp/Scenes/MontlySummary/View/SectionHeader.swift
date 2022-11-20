//
//  CustomHeader.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 20.11.2022.
//

import Foundation
import UIKit

class SectionHeader: UICollectionReusableView {
     lazy var header: UILabel = {
         let label: UILabel = UILabel()
         label.textColor = CustomColor.textColorSecondary
         label.font = UIFont.Poppins.semiBold(size: 15).font
         label.sizeToFit()
         label.textAlignment = .center
         return label
     }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .clear
        return view
    }()

     override init(frame: CGRect) {
         super.init(frame: frame)
         addSubview(mainView)
         mainView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
         
         mainView.addSubview(header)         
         header.anchorCenter(centerX: nil, centerY: centerYAnchor)
         header.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
