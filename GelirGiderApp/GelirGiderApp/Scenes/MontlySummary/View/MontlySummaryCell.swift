//
//  MontlySummaryCell.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 6.11.2022.
//

import Foundation
import UIKit

final class MontlySummaryCell: UICollectionViewCell {
    
    internal lazy var lblYearMonth: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.bold(size: 12).font
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.minimumScaleFactor = 0.6
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    internal lazy var lblIncome: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.medium(size: 12).font
        lbl.textColor = CustomColor.textColor
        lbl.textAlignment = .left
        lbl.text = "Gelir"
        return lbl
    }()
    
    internal lazy var lblExpense: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.medium(size: 12).font
        lbl.textColor = CustomColor.textColor
        lbl.textAlignment = .left
        lbl.text = "Gider"
        return lbl
    }()
    
    internal lazy var lblSubstract: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.medium(size: 12).font
        lbl.textColor = CustomColor.textColor
        lbl.textAlignment = .left
        lbl.text = "Fark"
        return lbl
    }()
    
    internal lazy var lblIncomeValue: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.bold(size: 12).font
        lbl.textColor = CustomColor.textColorGreen
        lbl.textAlignment = .left
        return lbl
    }()
    
    internal lazy var lblExpenseValue: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.bold(size: 12).font
        lbl.textColor = CustomColor.textColorRed
        lbl.textAlignment = .left
        return lbl
    }()
    
    internal lazy var lblSubstractValue: UILabel = {
        let lbl = UILabel()
        lbl.font = .Poppins.bold(size: 12).font
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var pointViewIncome: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.textColorGreen
        return view
    }()
    
    private lazy var pointViewExpense: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.textColorRed
        return view
    }()
    
    private lazy var pointViewSubstract: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var pieView: PieView = {
       let view = PieView()
        return view
    }()
    
    internal var customColor: UIColor = CustomColor.textColorGreen! {
        didSet {
            lblSubstractValue.textColor = customColor
            pointViewSubstract.backgroundColor = customColor
        }
    }
    
    internal var montlySummaryItem: MontlySummaryPresentation? {
        didSet {
            guard let item = montlySummaryItem else { return }
            lblYearMonth.text = "\(item.year)  \(Date.getMonthName(month: item.month))"
            lblIncomeValue.text = item.income.stringValue
            lblExpenseValue.text = item.expense.stringValue
            lblSubstractValue.text = item.substract.stringValue
            customColor = item.substract >= 0 ? CustomColor.textColorGreen! : CustomColor.textColorRed!
            pieView.percentage = (item.substract / item.income) * 100
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        locateHeader()
        locateListView()
        let imgView = locateRightImage()
        locatePieView(imageView: imgView)
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
        headerView.backgroundColor = CustomColor.cellHeaderColor
        headerView.layer.cornerRadius = 18
        headerView.layer.masksToBounds = true
        headerView.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMaxYCorner])
        
        addSubview(headerView)
        headerView.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 130, height: 25)
        
        headerView.addSubview(lblYearMonth)
        lblYearMonth.anchorCenter(centerX: headerView.centerXAnchor, centerY: headerView.centerYAnchor)
    }
    
    fileprivate func locateListView() {
        let listView = UIView()
        
        addSubview(listView)
        listView.anchor(top: headerView.bottomAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: nil, paddingTop: 10, paddingBottom: -10, paddingTrailing: 0, paddingLeading: 10, width: 0, height: 0)
        
        let itemIncome = getItemView(label: lblIncome, valueLabel: lblIncomeValue, pointView: pointViewIncome)
        let itemExpense = getItemView(label: lblExpense, valueLabel: lblExpenseValue, pointView: pointViewExpense)
        let itemsubstract = getItemView(label: lblSubstract, valueLabel: lblSubstractValue, pointView: pointViewSubstract)
        
        let stackView = UIStackView(arrangedSubviews: [itemIncome, itemExpense, itemsubstract])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        listView.addSubview(stackView)
        stackView.anchor(top: listView.topAnchor, bottom: listView.bottomAnchor, leading: listView.leadingAnchor, trailing: listView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
    }
    
    fileprivate func locateRightImage() -> UIImageView {
        let image = UIImageView(image: UIImage(systemName: "chevron.right"))
        image.tintColor = CustomColor.cellBorderColor
        addSubview(image)
        image.anchorCenter(centerX: nil, centerY: centerYAnchor)
        image.anchor(top: nil, bottom: nil, leading: nil, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: -20, paddingLeading: 0, width: 0, height: 0)
        return image
    }
    
    fileprivate func locatePieView(imageView: UIImageView) {
        addSubview(pieView)
        pieView.anchorCenter(centerX: nil, centerY: centerYAnchor)
        pieView.anchor(top: nil, bottom: nil, leading: nil, trailing: imageView.leadingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: -20, paddingLeading: 0, width: 60, height: 60)
        pieView.layer.cornerRadius = 30
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
