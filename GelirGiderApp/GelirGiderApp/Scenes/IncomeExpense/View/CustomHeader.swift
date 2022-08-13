//
//  CustomHeader.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 12.04.2022.
//

import Foundation
import UIKit

final class CustomHeader: UITableViewHeaderFooterView {
    
    private lazy var lblGider: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 12)
        lbl.textColor = CustomColor.textColor
        lbl.sizeToFit()
        return lbl
    }()
    
    private lazy var roundedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7.5
        return view
    }()
    
    private lazy var countText: UILabel = {
        let text = UILabel()
        text.font = .boldSystemFont(ofSize: 12)
        text.sizeToFit()
        return text
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    internal func configure (with viewModel: CustomHeaderViewModel) {
        lblGider.text = viewModel.incomeExpenseText
        countText.text = String(viewModel.count)
        countText.textColor = viewModel.roundedViewTextColor
        roundedView.backgroundColor = viewModel.roundedViewBackgroundColor
        
        let mainView = UIView()
        
        roundedView.addSubview(countText)
        countText.translatesAutoresizingMaskIntoConstraints = false
        countText.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor).isActive = true
        countText.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [lblGider, roundedView])
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        
        let textWidth = countText.text!.width(forHeight: 15, font: .boldSystemFont(ofSize: 12))
        roundedView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 5, width: textWidth + 5, height: 15)
        
        mainView.addSubview(stackView)
        stackView.anchor(top: mainView.topAnchor, bottom: mainView.bottomAnchor, leading: mainView.leadingAnchor, trailing: mainView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        
        addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

internal struct CustomHeaderViewModel {
    let count: Int
    let roundedViewTextColor: UIColor
    let roundedViewBackgroundColor: UIColor
    let incomeExpenseText: String
}
