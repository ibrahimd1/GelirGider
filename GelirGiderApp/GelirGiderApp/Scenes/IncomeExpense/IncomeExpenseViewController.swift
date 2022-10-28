//
//  ViewController.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 29.10.2021.
//

import UIKit
import RealmSwift

class IncomeExpenseViewController: UIViewController {
    
    private lazy var txtYearMont: UITextView = {
        let date = Date()
        let txt = UITextView()
        txt.isEditable = false
        txt.isScrollEnabled = false
        txt.textAlignment = .center
        txt.attributedText = getAttrText(String(date.currentYear), date.currentMonthName)
        txt.textColor = CustomColor.textColor
        txt.backgroundColor = CustomColor.backgroundColor
        return txt
    }()
    
    private lazy var txtDescription: UITextField = {
        let txt = CustomTextField()
        txt.configure(with: CustomTextFieldViewModel(placeHolderText: "Gelir/Gider Adı", icon: "DescriptionIcon", keyboardType: .default))
        return txt
    }()
    
    private lazy var txtAmount: UITextField = {
        let txt = CustomTextField()
        txt.configure(with: CustomTextFieldViewModel(placeHolderText: "Tutar", icon: "CurrencyIcon", keyboardType: .decimalPad))
        return txt
    }()
    
    private lazy var btnIncome: UIButton = {
        let btn = RoundedButton()
        btn.configure(with: RoundedButtonViewModel(text: "Gelir Ekle",
                                                   icon: UIImage(named: "IncomeButtonIcon")!,
                                                   titleColor: CustomColor.textColor!,
                                                   backgroundColor: CustomColor.backgroundColorComponent!))
        return btn
    }()
    
    private lazy var btnExpense: UIButton = {
        let btn = RoundedButton()
        btn.configure(with: RoundedButtonViewModel(text: "Gider Ekle",
                                                   icon: UIImage(named: "ExpenseButtonIcon")!,
                                                   titleColor: CustomColor.textColor!,
                                                   backgroundColor: CustomColor.backgroundColorComponent!))
        return btn
    }()
    
    private lazy var tableIncome: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = CustomColor.backgroundColor
        return tableView
    }()
    
    private lazy var tableExpense: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = CustomColor.backgroundColor
        return tableView
    }()
    
    private lazy var seperatorFooter: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.seperatorColor
        return view
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.footerBackgroundColor
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var lblIncome: UILabel = {
        let lbl = UILabel()
        lbl.text = "Gelir"
        lbl.font = .Poppins.semiBold(size: 12).font
        lbl.textAlignment = .center
        lbl.textColor = CustomColor.textColorSecondary
        return lbl
    }()
    
    private lazy var lblIncomeSum: UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        lbl.font = .Poppins.bold(size: 13).font
        lbl.textAlignment = .center
        lbl.textColor = CustomColor.textColorGreen
        return lbl
    }()
    
    private lazy var lblExpense: UILabel = {
        let lbl = UILabel()
        lbl.text = "Gider"
        lbl.font = .Poppins.semiBold(size: 12).font
        lbl.textAlignment = .center
        lbl.textColor = CustomColor.textColorSecondary
        return lbl
    }()
    
    private lazy var lblExpenseSum: UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        lbl.font = .Poppins.bold(size: 13).font
        lbl.textAlignment = .center
        lbl.textColor = CustomColor.textColorRed
        return lbl
    }()
    
    private lazy var lblSubstract: UILabel = {
        let lbl = UILabel()
        lbl.text = "Fark"
        lbl.font = .Poppins.semiBold(size: 12).font
        lbl.textAlignment = .center
        lbl.textColor = CustomColor.textColorSecondary
        return lbl
    }()
    
    private lazy var lblSubstractSum: UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        lbl.font = .Poppins.bold(size: 13).font
        lbl.textAlignment = .center
        lbl.textColor = CustomColor.textColorGreen
        return lbl
    }()
    
    private lazy var segmentedControl: CustomSegmentedControl = {
        let items = ["Gelir","Gider"]
        let sgm = CustomSegmentedControl(items: items)
        sgm.selectedSegmentIndex = 0
        sgm.addTarget(self, action: #selector(segmentedControlIndexChanged), for: .valueChanged)
        return sgm
    }()
    
    private lazy var scView: UIView = {
        let tempView = UIView()
        tempView.backgroundColor = CustomColor.backgroundColorComponent
        return tempView
    }()
    
    private var itemListIncome: IncomeExpensePresentation?
    private var itemListExpense: IncomeExpensePresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHideKeyboardOnTap()
        
        locateMainComponents()
        locateTextComponents()
        locateButtons()
        locateTable()
        locateFooer()
        
        tableTest()
    }
    
    fileprivate func locateMainComponents() {
        view.backgroundColor = CustomColor.backgroundColor
        navigationItem.titleView = txtYearMont
        
        let menuImage = UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(menuClick))
    }
    
    fileprivate func locateTextComponents() {
        let oranUzunluk = (view.bounds.width - 48) / 3
        view.addSubview(txtDescription)
        txtDescription.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: 15, paddingBottom: 0, paddingTrailing: -5, paddingLeading: 16, width: oranUzunluk * 2, height: 38)
        
        view.addSubview(txtAmount)
        txtAmount.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: txtDescription.trailingAnchor, trailing: view.trailingAnchor, paddingTop: 15, paddingBottom: 0, paddingTrailing: -16, paddingLeading: 16, width: 0, height: 38)
    }
    
    fileprivate func locateButtons() {
        
        // Income + Expense Buttons
        let stackViewButton = UIStackView(arrangedSubviews: [btnIncome,btnExpense])
        stackViewButton.distribution = .fillEqually
        stackViewButton.axis = .horizontal
        stackViewButton.spacing = 10
        
        view.addSubview(stackViewButton)
        stackViewButton.anchor(top: txtDescription.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingTrailing: -16, paddingLeading: 16, width: 0, height: 38)
        
        scView.addSubview(segmentedControl)
        segmentedControl.anchor(top: scView.topAnchor, bottom: scView.bottomAnchor, leading: scView.leadingAnchor, trailing: scView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        
        scView.layer.cornerRadius = 20
        
        view.addSubview(scView)
        scView.anchor(top: stackViewButton.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingTrailing: -30, paddingLeading: 30, width: 0, height: 38)
    }
    
    fileprivate func locateTable() {
        tableIncome.delegate = self
        tableIncome.dataSource = self
        tableIncome.register(IncomeExpenseCell.self, forCellReuseIdentifier: "incomeExpenseCell")
        
        view.addSubview(tableIncome)
        tableIncome.anchor(top: scView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingTrailing: -16, paddingLeading: 16, width: 0, height: 0)
        
        tableIncome.separatorColor = .clear
    }
    
    fileprivate func locateFooer() {
        let incomeSumView = getSummaryView(.income)
        let expenseSumView = getSummaryView(.expense)
        let subtractSumView = getSummaryView(.substract)
        
        let footerStackView = UIStackView(arrangedSubviews: [incomeSumView,expenseSumView,subtractSumView])
        footerStackView.distribution = .fillEqually
        footerStackView.axis = .horizontal
        footerStackView.spacing = 10
        footerStackView.alignment = .center
        
        view.addSubview(seperatorFooter)
        seperatorFooter.anchor(top: tableIncome.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: -5, paddingTrailing: -32, paddingLeading: 32, width: 0, height: 1)
        
        view.addSubview(footerStackView)
        footerStackView.anchor(top: seperatorFooter.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingTrailing: -16, paddingLeading: 16, width: 0, height: 50)
    }
    
    @objc func menuClick() {}
    
    func getAttrText(_ year: String, _ month: String) -> NSMutableAttributedString {
        let attrText = NSMutableAttributedString(string: year, attributes: [.font : UIFont.Poppins.semiBold(size: 18).font!])
        attrText.append(NSAttributedString(string: " \(month)", attributes: [.font : UIFont.Poppins.semiBold(size: 12).font! ]))
        return attrText
    }
    
    @objc func segmentedControlIndexChanged(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            break
        case 1:
            break
        default:
            break
        }
    }
    
    fileprivate func getSummaryView(_ summaryType: SummaryViewType) -> UIView {
        var tempView: UIView
        var tempViewSum: UIView
        if(summaryType == .income) {
            tempView = lblIncome
            tempViewSum = lblIncomeSum
        } else if (summaryType == .expense) {
            tempView = lblExpense
            tempViewSum = lblExpenseSum
        } else {
            tempView = lblSubstract
            tempViewSum = lblSubstractSum
        }
        
        let sumView = UIView()
        sumView.addSubview(tempView)
        tempView.anchor(top: sumView.topAnchor, bottom: nil, leading: sumView.leadingAnchor, trailing: sumView.trailingAnchor, paddingTop: 5, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        sumView.addSubview(tempViewSum)
        tempViewSum.anchor(top: tempView.bottomAnchor, bottom: sumView.bottomAnchor, leading: sumView.leadingAnchor, trailing: sumView.trailingAnchor, paddingTop: 7, paddingBottom: -7, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        return sumView
    }
    
    func tableTest() {
        let i1 = IncomeExpenseItemModel(type: .income, desc: "Market", dateTime: Date(), amount: 32.45)
        let i2 = IncomeExpenseItemModel(type: .income, desc: "Araba Kasko", dateTime: Date(), amount: 1532.45)
        let i3 = IncomeExpenseItemModel(type: .income, desc: "Dışarıda Yemek", dateTime: Date(), amount: 25165)
        let i4 = IncomeExpenseItemModel(type: .income, desc: "Kafe", dateTime: Date(), amount: 5332.77)
        let i5 = IncomeExpenseItemModel(type: .income, desc: "Ev Kirası", dateTime: Date(), amount: 2.5)
        let i6 = IncomeExpenseItemModel(type: .income, desc: "Ev Harcama Test", dateTime: Date(), amount: 158.12)
        let i7 = IncomeExpenseItemModel(type: .income, desc: "Araba Kasko", dateTime: Date(), amount: 1532.45)
        let i8 = IncomeExpenseItemModel(type: .income, desc: "Dışarıda Yemek", dateTime: Date(), amount: 25165)
        let i9 = IncomeExpenseItemModel(type: .income, desc: "Kafe", dateTime: Date(), amount: 5332.77)
        let i10 = IncomeExpenseItemModel(type: .income, desc: "Ev Kirası", dateTime: Date(), amount: 2.5)
        let i11 = IncomeExpenseItemModel(type: .income, desc: "Ev Harcama Test", dateTime: Date(), amount: 158.12)
        let list = List<IncomeExpenseItemModel>()
        list.append(i1)
        list.append(i2)
        list.append(i3)
        list.append(i4)
        list.append(i5)
        list.append(i6)
        list.append(i7)
        list.append(i8)
        list.append(i9)
        list.append(i10)
        list.append(i11)
        
        self.itemListIncome = IncomeExpensePresentation(model: IncomeExpenseModel(year: 2022, month: 10, incomeExpenseList: list))
        
        let incomeSum = list.filter({ $0.type == .income }).map({$0.amountOfIncomeExpense}).reduce(0, +)
        let expenseSum = list.filter({ $0.type == .expense }).map({$0.amountOfIncomeExpense}).reduce(0, +)
        let substractSum = incomeSum - expenseSum
        
        lblIncomeSum.text = incomeSum.stringValue
        lblExpenseSum.text = expenseSum.stringValue
        lblSubstractSum.text = substractSum.stringValue
        
        tableIncome.reloadData()
    }
}

extension IncomeExpenseViewController: UITableViewDelegate {
}

extension IncomeExpenseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableIncome {
            guard let incomeList = itemListIncome else { return 0 }
            return incomeList.itemList.count
        } else {
            guard let expenseList = itemListExpense else { return 0 }
            return expenseList.itemList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableIncome {
            guard let incomeList = itemListIncome else { return UITableViewCell() }
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "incomeExpenseCell", for: indexPath) as? IncomeExpenseCell {
                cell.lblTitle.text = incomeList.itemList[indexPath.row].description
                cell.lblSubTitle.text = incomeList.itemList[indexPath.row].dateTime.formattedDateDMY
                cell.lblCurrency.text = incomeList.itemList[indexPath.row].amount.stringValue
                cell.imgIcon.image = UIImage(named: "IncomeIcon")
                cell.itemIndex = indexPath.row
                cell.title = incomeList.itemList[indexPath.row].description
                cell.selectionStyle = .none
                return cell
            }
        } else {
            guard let expenseList = itemListExpense else { return UITableViewCell() }
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "incomeExpenseCell", for: indexPath) as? IncomeExpenseCell {
                cell.lblTitle.text = expenseList.itemList[indexPath.row].description
                cell.lblSubTitle.text = expenseList.itemList[indexPath.row].dateTime.formattedDateDMY
                cell.lblCurrency.text = expenseList.itemList[indexPath.row].amount.stringValue
                cell.imgIcon.image = UIImage(named: "ExpenseIcon")
                cell.itemIndex = indexPath.row
                cell.title = expenseList.itemList[indexPath.row].description
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
