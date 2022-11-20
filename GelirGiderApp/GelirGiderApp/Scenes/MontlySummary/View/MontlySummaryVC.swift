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
    
    private lazy var tableMontlySummary: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 15
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        
        let tableView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        tableView.backgroundColor = CustomColor.backgroundColor
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.delegate = self
        viewModel.load()
        
        locateTable()
        //testData()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = CustomColor.backgroundColor
        
        let btn = UIBarButtonItem()
        btn.title = "Geri"
        btn.tintColor = CustomColor.textColor
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = btn
    }
    
    fileprivate func locateTable() {
        self.tableMontlySummary.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        tableMontlySummary.register(MontlySummaryCell.self, forCellWithReuseIdentifier: "montlySummaryCell")
        tableMontlySummary.delegate = self
        tableMontlySummary.dataSource = self
        
        view.addSubview(tableMontlySummary)
        tableMontlySummary.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: -20, paddingTrailing: -16, paddingLeading: 16, width: 0, height: 0)
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
    
    func getUniqueYears() -> [Int] {
        let years = self.itemList.map { $0.year }
        let uniqueYears = Set(years)
        return Array(uniqueYears).sorted { $0 > $1 }
    }
}

extension MontlySummaryViewController: MontlySummaryViewModelDelegate {
    func handleViewModelOutput(_ output: MontlySummaryViewModelOutput) {
        switch output {
        case .updateHeader(let title):
            self.title = title
        case .showData(let data):
            self.itemList = data
            self.tableMontlySummary.reloadData()
        }
    }
    
    func navigate(to route: MontlySummaryRoute) {
        switch route {
        case .detail(let viewModel):
            let detailVC = IncomeExpenseBuilder.make(with: viewModel)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension MontlySummaryViewController: UICollectionViewDelegate {}

extension MontlySummaryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let count = getUniqueYears().count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let uniqueYears = getUniqueYears()
        return self.itemList.filter { $0.year == uniqueYears[section] }.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let uniqueYears = getUniqueYears()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "montlySummaryCell", for: indexPath) as? MontlySummaryCell {
            cell.montlySummaryItem = self.itemList.filter({ $0.year == uniqueYears[indexPath.section] })[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uniqueYears = getUniqueYears()
        let item = self.itemList.filter({ $0.year == uniqueYears[indexPath.section] })[indexPath.row]
        viewModel.selectItem(year: item.year, month: item.month)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let uniqueYears = getUniqueYears()
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
            sectionHeader.header.text = "\(uniqueYears[indexPath.section])"
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}

extension MontlySummaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width - 16.0 * 2
        let height = 120.0
        return CGSize(width: width, height: height)
    }
}

