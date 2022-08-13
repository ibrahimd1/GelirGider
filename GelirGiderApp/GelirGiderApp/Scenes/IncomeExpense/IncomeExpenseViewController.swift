//
//  ViewController.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 29.10.2021.
//

import UIKit

class IncomeExpenseViewController: UIViewController {
    
    private lazy var txtYearMont: UITextView = {
        let txt = UITextView()
        txt.isEditable = false
        txt.isScrollEnabled = false
        txt.textAlignment = .center
        txt.attributedText = getAttrText("2022", "Ekim")
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
                                                   titleColor: CustomColor.primaryGreen!,
                                                   backgroundColor: CustomColor.backgroundColorGreen!))
        return btn
    }()
    
    private lazy var btnExpense: UIButton = {
        let btn = RoundedButton()
        btn.configure(with: RoundedButtonViewModel(text: "Gider Ekle",
                                                   icon: UIImage(named: "ExpenseButtonIcon")!,
                                                   titleColor: CustomColor.primaryRed!,
                                                   backgroundColor: CustomColor.backgroundColorRed!))
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
    
    private lazy var seperator: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.lineColor
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
        lbl.font = .boldSystemFont(ofSize: 12)
        lbl.textAlignment = .center
        lbl.textColor = CustomColor.textColor
        return lbl
    }()
    
    private lazy var lblIncomeSum: UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        lbl.font = .systemFont(ofSize: 11)
        lbl.textAlignment = .center
        lbl.textColor = CustomColor.textColor
        return lbl
    }()
    
    private lazy var lblExpense: UILabel = {
        let lbl = UILabel()
        lbl.text = "Gider"
        lbl.font = .boldSystemFont(ofSize: 12)
        lbl.textAlignment = .center
        lbl.textColor = CustomColor.textColor
        return lbl
    }()
    
    private lazy var lblExpenseSum: UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        lbl.font = .systemFont(ofSize: 11)
        lbl.textAlignment = .center
        lbl.textColor = CustomColor.textColor
        return lbl
    }()
    
    private lazy var lblSubstract: UILabel = {
        let lbl = UILabel()
        lbl.text = "Fark"
        lbl.font = .boldSystemFont(ofSize: 12)
        lbl.textAlignment = .center
        lbl.textColor = CustomColor.textColor
        return lbl
    }()
    
    private lazy var lblSubstractSum: UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        lbl.font = .systemFont(ofSize: 11)
        lbl.textAlignment = .center
        lbl.textColor = CustomColor.textColor
        return lbl
    }()
    
    private var itemListIncome: IncomeExpensePresentation?
    private var itemListExpense: IncomeExpensePresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CustomColor.backgroundColor
        navigationItem.titleView = UIImageView(image: UIImage(named: "GelirGiderIcon"))
        
        let menuImage = UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(menuClick))
        
        //Year + Month
        view.addSubview(txtYearMont)
        txtYearMont.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        txtYearMont.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //Description + Amount TextField
        let oranUzunluk = (view.bounds.width - 48) / 3
        
        view.addSubview(txtDescription)
        txtDescription.anchor(top: txtYearMont.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil, paddingTop: 15, paddingBottom: 0, paddingTrailing: -5, paddingLeading: 16, width: oranUzunluk * 2, height: 38)
        
        view.addSubview(txtAmount)
        txtAmount.anchor(top: txtYearMont.bottomAnchor, bottom: nil, leading: txtDescription.trailingAnchor, trailing: view.trailingAnchor, paddingTop: 15, paddingBottom: 0, paddingTrailing: -16, paddingLeading: 16, width: 0, height: 38)
        
        // Income + Expense Buttons
        let stackViewButton = UIStackView(arrangedSubviews: [btnIncome,btnExpense])
        stackViewButton.distribution = .fillEqually
        stackViewButton.axis = .horizontal
        stackViewButton.spacing = 10
        
        view.addSubview(stackViewButton)
        stackViewButton.anchor(top: txtDescription.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingTrailing: -16, paddingLeading: 16, width: 0, height: 38)
        
        // Income + Expense Tables
        tableIncome.delegate = self
        tableIncome.dataSource = self
        tableExpense.delegate = self
        tableExpense.dataSource = self
        tableIncome.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "customHeader")
        tableExpense.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "customHeader")
        tableIncome.register(IncomeExpenseCell.self, forCellReuseIdentifier: "incomeCell")
        tableExpense.register(IncomeExpenseCell.self, forCellReuseIdentifier: "incomeCell")
        
        let stackViewTable = UIStackView(arrangedSubviews: [tableIncome,seperator,tableExpense])
        stackViewTable.distribution = .fillEqually
        stackViewTable.axis = .horizontal
        stackViewTable.spacing = 10
        
        let tableWidth = (view.bounds.width - 63) / 2
        let table = UIView()
        
        table.addSubview(tableIncome)
        tableIncome.anchor(top: table.topAnchor, bottom: table.bottomAnchor, leading: table.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: tableWidth, height: 0)
        table.addSubview(seperator)
        seperator.anchor(top: table.topAnchor, bottom: table.bottomAnchor, leading: tableIncome.trailingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 15, width: 1, height: 0)
        table.addSubview(tableExpense)
        tableExpense.anchor(top: table.topAnchor, bottom: table.bottomAnchor, leading: seperator.trailingAnchor, trailing: table.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 15, width: tableWidth, height: 0)
        
        view.addSubview(table)
        table.anchor(top: stackViewButton.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingTrailing: -16, paddingLeading: 16, width: 0, height: 0)
        
        tableIncome.separatorColor = .clear
        tableExpense.separatorColor = .clear
        
        //Footer
        
        //Income
        let incomeSumView = UIView()
        incomeSumView.addSubview(lblIncome)
        lblIncome.anchor(top: incomeSumView.topAnchor, bottom: nil, leading: incomeSumView.leadingAnchor, trailing: incomeSumView.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        incomeSumView.addSubview(lblIncomeSum)
        lblIncomeSum.anchor(top: lblIncome.bottomAnchor, bottom: incomeSumView.bottomAnchor, leading: incomeSumView.leadingAnchor, trailing: incomeSumView.trailingAnchor, paddingTop: 5, paddingBottom: -10, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        
        //Expense
        let expenseSumView = UIView()
        expenseSumView.addSubview(lblExpense)
        lblExpense.anchor(top: expenseSumView.topAnchor, bottom: nil, leading: expenseSumView.leadingAnchor, trailing: expenseSumView.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        expenseSumView.addSubview(lblExpenseSum)
        lblExpenseSum.anchor(top: lblExpense.bottomAnchor, bottom: expenseSumView.bottomAnchor, leading: expenseSumView.leadingAnchor, trailing: expenseSumView.trailingAnchor, paddingTop: 5, paddingBottom: -10, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        
        //Substract
        let substractSumView = UIView()
        substractSumView.addSubview(lblSubstract)
        lblSubstract.anchor(top: substractSumView.topAnchor, bottom: nil, leading: substractSumView.leadingAnchor, trailing: substractSumView.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        substractSumView.addSubview(lblSubstractSum)
        lblSubstractSum.anchor(top: lblSubstract.bottomAnchor, bottom: substractSumView.bottomAnchor, leading: substractSumView.leadingAnchor, trailing: substractSumView.trailingAnchor, paddingTop: 5, paddingBottom: -10, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        
        let footerStackView = UIStackView(arrangedSubviews: [incomeSumView,expenseSumView,substractSumView])
        footerStackView.distribution = .fillEqually
        footerStackView.axis = .horizontal
        footerStackView.spacing = 10
        footerStackView.alignment = .center
        
        footerView.addSubview(footerStackView)
        footerStackView.anchor(top: footerView.topAnchor, bottom: footerView.bottomAnchor, leading: footerView.leadingAnchor, trailing: footerView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        
        view.addSubview(footerView)
        footerView.anchor(top: table.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingTrailing: -16, paddingLeading: 16, width: view.bounds.width - 32, height: 50)
    }
    
    @objc func menuClick() {}
    
    func getAttrText(_ year: String, _ month: String) -> NSMutableAttributedString {
        let attrText = NSMutableAttributedString(string: year, attributes: [.font : UIFont.boldSystemFont(ofSize: 18)])
        attrText.append(NSAttributedString(string: " \(month)", attributes: [.font : UIFont.boldSystemFont(ofSize: 12) ]))
        return attrText
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
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCell", for: indexPath) as? IncomeExpenseCell {
                cell.lblTitle.text = incomeList.itemList[indexPath.row].description
                cell.lblSubTitle.text = incomeList.itemList[indexPath.row].dateTime.formattedDateDMY
                cell.lblCurrency.text = incomeList.itemList[indexPath.row].amount.stringValue
                cell.imgIcon.image = UIImage(named: "IncomeIcon")
                return cell
            }
        } else {
            guard let expenseList = itemListExpense else { return UITableViewCell() }
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCell", for: indexPath) as? IncomeExpenseCell {
                cell.lblTitle.text = expenseList.itemList[indexPath.row].description
                cell.lblSubTitle.text = expenseList.itemList[indexPath.row].dateTime.formattedDateDMY
                cell.lblCurrency.text = expenseList.itemList[indexPath.row].amount.stringValue
                cell.imgIcon.image = UIImage(named: "ExpenseIcon")
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == tableIncome {
            var incomeListCount = 0
            if let incomeList = itemListIncome {
                incomeListCount = incomeList.itemList.count
            }
            
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                    "customHeader") as! CustomHeader
            view.configure(with: CustomHeaderViewModel(count: incomeListCount, roundedViewTextColor: CustomColor.primaryGreen!, roundedViewBackgroundColor: CustomColor.backgroundColorGreen!, incomeExpenseText: "Gelir"))
            return view
        } else {
            var expenseListCount = 0
            if let expenseList = itemListExpense {
                expenseListCount = expenseList.itemList.count
            }
            
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                    "customHeader") as! CustomHeader
            view.configure(with: CustomHeaderViewModel(count: expenseListCount, roundedViewTextColor: CustomColor.primaryRed!, roundedViewBackgroundColor: CustomColor.backgroundColorRed!, incomeExpenseText: "Gider"))
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
