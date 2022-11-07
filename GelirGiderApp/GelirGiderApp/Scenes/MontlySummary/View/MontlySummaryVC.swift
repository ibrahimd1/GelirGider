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
    
    private var data: [String] = []
    
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
        view.backgroundColor = CustomColor.backgroundColor
        viewModel.delegate = self
        viewModel.load()
        
        locateTable()
        
        data.append("2022 Kasım")
        data.append("2022 Ekim")
        data.append("2022 Eylül")
        data.append("2022 Ağustos")
        data.append("Test Temmuz")
    }
    
    fileprivate func locateTable() {
        
        tableMontlySummary.register(MontlySummaryCell.self, forCellWithReuseIdentifier: "montlySummaryCell")
        tableMontlySummary.delegate = self
        tableMontlySummary.dataSource = self
        
        view.addSubview(tableMontlySummary)
        tableMontlySummary.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 20, paddingBottom: 0, paddingTrailing: -16, paddingLeading: 16, width: 0, height: 0)
    }
}

extension MontlySummaryViewController: MontlySummaryViewModelDelegate {
    func handleViewModelOutput(_ output: MontlySummaryViewModelOutput) {
        switch output {
        case .updateHeader(let title):
            self.title = title
        }
    }
}

extension MontlySummaryViewController: UICollectionViewDelegate {}

extension MontlySummaryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "montlySummaryCell", for: indexPath) as? MontlySummaryCell {
            cell.lblTitle.text = data[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MontlySummaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width - 16.0 * 2
        let height = 100.0
        return CGSize(width: width, height: height)
    }
}

