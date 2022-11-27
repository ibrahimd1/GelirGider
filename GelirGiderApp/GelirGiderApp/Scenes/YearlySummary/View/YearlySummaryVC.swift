//
//  YearlySummaryVC.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 22.11.2022.
//

import Foundation
import UIKit

final class YearlySummaryViewController: UIViewController {
    
    var viewModel: YearlySummaryViewModelProtocol!
    private var yearPresentationList: [YearlySummaryPresentation] = []
    
    private lazy var tableYearlySummary: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 15
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let tableView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        tableView.backgroundColor = CustomColor.backgroundColor
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.load()
        setupView()
        locateTable()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = CustomColor.backgroundColor
        
        let btn = UIBarButtonItem()
        btn.title = "Geri"
        btn.tintColor = CustomColor.textColor
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = btn
    }
    
    fileprivate func locateTable() {
        tableYearlySummary.register(YearlySummaryCell.self, forCellWithReuseIdentifier: "yearlySummaryCell")
        tableYearlySummary.delegate = self
        tableYearlySummary.dataSource = self
        
        view.addSubview(tableYearlySummary)
        tableYearlySummary.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 20, paddingBottom: -20, paddingTrailing: -16, paddingLeading: 16, width: 0, height: 0)
    }
}

extension YearlySummaryViewController: YearlySummaryViewModelDelegate {
    func handleViewModelOutput(_ output: YearlySummaryViewModelOutput) {
        switch output {
        case .updateHeader(let title):
            self.title = title
        case .showData(let dataList):
            self.yearPresentationList = dataList
            self.tableYearlySummary.reloadData()
        }
    }
}

extension YearlySummaryViewController: UICollectionViewDelegate {}

extension YearlySummaryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yearPresentationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "yearlySummaryCell", for: indexPath) as? YearlySummaryCell {
            cell.yearlySummaryItem = yearPresentationList[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
}

extension YearlySummaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width - 16.0 * 2
        let height = 120.0
        return CGSize(width: width, height: height)
    }
}
