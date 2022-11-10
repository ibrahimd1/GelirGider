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
        
        tableMontlySummary.register(MontlySummaryCell.self, forCellWithReuseIdentifier: "montlySummaryCell")
        tableMontlySummary.delegate = self
        tableMontlySummary.dataSource = self
        
        view.addSubview(tableMontlySummary)
        tableMontlySummary.anchor(top: view.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 20, paddingBottom: -20, paddingTrailing: -16, paddingLeading: 16, width: 0, height: 0)
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
}

extension MontlySummaryViewController: MontlySummaryViewModelDelegate {
    func handleViewModelOutput(_ output: MontlySummaryViewModelOutput) {
        switch output {
        case .updateHeader(let title):
            self.title = title
        case .showData(let data):
            self.itemList = data
            tableMontlySummary.reloadData()
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

