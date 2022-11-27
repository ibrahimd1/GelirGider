//
//  YearlySummaryCell.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 27.11.2022.
//

import Foundation
import UIKit

final class YearlySummaryCell: UICollectionViewCell {
    
    internal lazy var lblYear: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.bold(size: 12).font
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.minimumScaleFactor = 0.6
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    internal lazy var lblYearIncome: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.medium(size: 12).font
        lbl.textColor = CustomColor.textColor
        lbl.textAlignment = .left
        lbl.text = "Gelir"
        return lbl
    }()
    
    internal lazy var lblYearExpense: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.medium(size: 12).font
        lbl.textColor = CustomColor.textColor
        lbl.textAlignment = .left
        lbl.text = "Gider"
        return lbl
    }()
    
    internal lazy var lblYearSubstract: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.medium(size: 12).font
        lbl.textColor = CustomColor.textColor
        lbl.textAlignment = .left
        lbl.text = "Fark"
        return lbl
    }()
    
    internal lazy var lblYearIncomeValue: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.bold(size: 12).font
        lbl.textColor = CustomColor.textColorGreen
        lbl.textAlignment = .left
        return lbl
    }()
    
    internal lazy var lblYearExpenseValue: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.bold(size: 12).font
        lbl.textColor = CustomColor.textColorRed
        lbl.textAlignment = .left
        return lbl
    }()
    
    internal lazy var lblYearSubstractValue: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.bold(size: 12).font
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var yearHeaderView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var yearPointViewIncome: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.textColorGreen
        return view
    }()
    
    private lazy var yearPointViewExpense: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.textColorRed
        return view
    }()
    
    private lazy var yearPointViewSubstract: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var yearPieView: PieView = {
       let view = PieView()
        return view
    }()
    
    internal var customColor: UIColor = CustomColor.textColorGreen! {
        didSet {
            lblYearSubstractValue.textColor = customColor
            yearPointViewSubstract.backgroundColor = customColor
        }
    }
    
    internal var yearlySummaryItem: YearlySummaryPresentation? {
        didSet {
            guard let item = yearlySummaryItem else { return }
            lblYear.text = "\(item.year)"
            lblYearIncomeValue.text = item.income.stringValue
            lblYearExpenseValue.text = item.expense.stringValue
            lblYearSubstractValue.text = item.substract.stringValue
            customColor = item.substract >= 0 ? CustomColor.textColorGreen! : CustomColor.textColorRed!
            yearPieView.percentage = (item.substract / item.income) * 100
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        locateHeader()
        locateListView()
        locatePieView()
    }
    
    fileprivate func getItemView(label: UILabel, valueLabel: UILabel, pointView: UIView) -> UIView {
        let itemView = UIView()
        
        itemView.addSubview(pointView)
        pointView.anchor(top: nil, bottom: nil, leading: itemView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 5, height: 5)
        pointView.anchorCenter(centerX: nil, centerY: itemView.centerYAnchor)
        pointView.layer.cornerRadius = 2.5
        
        itemView.addSubview(label)
        label.anchor(top: nil, bottom: nil, leading: pointView.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 6, width: 40, height: 0)
        label.anchorCenter(centerX: nil, centerY: itemView.centerYAnchor)
        
        itemView.addSubview(valueLabel)
        valueLabel.anchor(top: nil, bottom: nil, leading: label.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 6, width: 0, height: 0)
        valueLabel.anchorCenter(centerX: nil, centerY: itemView.centerYAnchor)
        return itemView
    }
    
    fileprivate func setupView() {
        backgroundColor = CustomColor.backgroundColor
        layer.borderWidth = 1
        layer.borderColor = CustomColor.cellBorderColor?.cgColor
        layer.cornerRadius = 17
    }
    
    fileprivate func locateHeader() {
        yearHeaderView.backgroundColor = CustomColor.cellHeaderColor
        yearHeaderView.layer.cornerRadius = 18
        yearHeaderView.layer.masksToBounds = true
        yearHeaderView.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMaxYCorner])
        
        addSubview(yearHeaderView)
        yearHeaderView.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 130, height: 25)
        
        yearHeaderView.addSubview(lblYear)
        lblYear.anchorCenter(centerX: yearHeaderView.centerXAnchor, centerY: yearHeaderView.centerYAnchor)
    }
    
    fileprivate func locateListView() {
        let listView = UIView()
        
        addSubview(listView)
        listView.anchor(top: yearHeaderView.bottomAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: nil, paddingTop: 10, paddingBottom: -10, paddingTrailing: 0, paddingLeading: 10, width: 0, height: 0)
        
        let itemIncome = getItemView(label: lblYearIncome, valueLabel: lblYearIncomeValue, pointView: yearPointViewIncome)
        let itemExpense = getItemView(label: lblYearExpense, valueLabel: lblYearExpenseValue, pointView: yearPointViewExpense)
        let itemsubstract = getItemView(label: lblYearSubstract, valueLabel: lblYearSubstractValue, pointView: yearPointViewSubstract)
        
        let stackView = UIStackView(arrangedSubviews: [itemIncome, itemExpense, itemsubstract])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        listView.addSubview(stackView)
        stackView.anchor(top: listView.topAnchor, bottom: listView.bottomAnchor, leading: listView.leadingAnchor, trailing: listView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
    }
    
    fileprivate func locatePieView() {
        addSubview(yearPieView)
        yearPieView.anchorCenter(centerX: nil, centerY: centerYAnchor)
        yearPieView.anchor(top: nil, bottom: nil, leading: nil, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: -20, paddingLeading: 0, width: 60, height: 60)
        yearPieView.layer.cornerRadius = 30
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
