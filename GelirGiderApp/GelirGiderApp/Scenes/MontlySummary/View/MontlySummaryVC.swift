//
//  MontlySummaryVC.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 6.11.2022.
//

import Foundation
import UIKit

final class MontlySummaryViewController: UIViewController {
    var viewModel: MontlySummaryViewModelProtocol!
    
    private var itemList: [MontlySummaryPresentation] = []
    private var yearList: [String] = []
    private var currentIndex = 0
    
    private lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        return pv
    }()
    
    private lazy var txtYear: UITextField = {
        let txt = CustomTextField()
        txt.maxLength = 20
        txt.configure(with: CustomTextFieldViewModel(placeHolderText: "Yıl", icon: "chevron.down", keyboardType: .default, iconType: .system))
        txt.textAlignment = .center
        txt.tintColor = .clear
        return txt
    }()
    
    private lazy var tableMontlySummary: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 15
        flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        
        let tableView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        tableView.backgroundColor = CustomColor.backgroundColor
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.delegate = self
        viewModel.load()
        
        locateTextYear()
        locateTable()
        locatePickerView()
        //testData()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = CustomColor.backgroundColor
        
        let btn = UIBarButtonItem()
        btn.title = "Geri"
        btn.tintColor = CustomColor.textColor
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = btn
    }
    
    fileprivate func locateTextYear() {
        view.addSubview(txtYear)
        txtYear.anchorCenter(centerX: view.centerXAnchor, centerY: nil)
        txtYear.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 150, height: 40)
    }
    
    fileprivate func locateTable() {
        tableMontlySummary.register(MontlySummaryCell.self, forCellWithReuseIdentifier: "montlySummaryCell")
        tableMontlySummary.delegate = self
        tableMontlySummary.dataSource = self
        
        view.addSubview(tableMontlySummary)
        tableMontlySummary.anchor(top: txtYear.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: -20, paddingTrailing: -16, paddingLeading: 16, width: 0, height: 0)
    }
    
    fileprivate func locatePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        txtYear.inputView = pickerView
        let toolBar = UIToolbar(frame:CGRect(x:0, y:0, width:100, height:100))
        toolBar.sizeToFit()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        let doneButton = UIBarButtonItem(title: "Seç", style: .plain, target: self, action: #selector(btnSelectClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Vazgeç", style: .plain, target: self, action: #selector(btnCancelClicked))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        txtYear.inputAccessoryView = toolBar
    }
    
    fileprivate func testData() {
        itemList.append(MontlySummaryPresentation(year: 2022, month: 11, income: 32000, expense: 25000, substract: 7000))
        itemList.append(MontlySummaryPresentation(year: 2022, month: 10, income: 32000, expense: 25000, substract: 7000))
        itemList.append(MontlySummaryPresentation(year: 2022, month: 9, income: 32000, expense: 25000, substract: 7000))
        itemList.append(MontlySummaryPresentation(year: 2022, month: 8, income: 32000, expense: 25000, substract: 7000))
        itemList.append(MontlySummaryPresentation(year: 2022, month: 7, income: 32000, expense: 25000, substract: 7000))
        itemList.append(MontlySummaryPresentation(year: 2022, month: 6, income: 32000, expense: 25000, substract: 7000))
        itemList.append(MontlySummaryPresentation(year: 2022, month: 5, income: 32000, expense: 25000, substract: 7000))
        itemList.append(MontlySummaryPresentation(year: 2022, month: 4, income: 32000, expense: 25000, substract: -150))
    }
    
    @objc func btnSelectClicked() {
        let yearStr = yearList[currentIndex]
        txtYear.text = yearStr
        view.endEditing(true)
        viewModel.didSelect(year: Int(yearStr)!, data: nil)
    }
    
    @objc func btnCancelClicked() {
        view.endEditing(true)
    }
}

extension MontlySummaryViewController: MontlySummaryViewModelDelegate {
    func handleViewModelOutput(_ output: MontlySummaryViewModelOutput) {
        switch output {
        case .updateHeader(let title):
            self.title = title
        case .showData(let data):
            self.itemList = data
            tableMontlySummary.reloadData()
        case .setPickerViewData(let list):
            self.yearList = list
            self.txtYear.text = list[0]
        case .updateYearText(let year):
            self.txtYear.text = year
        }
    }
}

extension MontlySummaryViewController: UICollectionViewDelegate {}

extension MontlySummaryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "montlySummaryCell", for: indexPath) as? MontlySummaryCell {
            cell.montlySummaryItem = itemList[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MontlySummaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width - 16.0 * 2
        let height = 120.0
        return CGSize(width: width, height: height)
    }
}

extension MontlySummaryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return yearList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentIndex = row
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearList.count
    }
}

