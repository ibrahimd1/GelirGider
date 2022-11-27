//
//  CustomModalViewController.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 28.10.2022.
//

import Foundation
import UIKit

internal final class CustomModalVC: UIViewController {
    
    lazy var contentStackView: UIStackView = {
       let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [tableMenu, btnCancel])
        stackView.axis = .vertical
        stackView.spacing = 15.0
        return stackView
    }()
    
    lazy var containerView: UIView = {
       let tempView = UIView()
        tempView.backgroundColor = .clear
        tempView.clipsToBounds = true
        return tempView
    }()
    
    let maxDimmedAlpha: CGFloat = 0.7
    lazy var dimmedView: UIView = {
        let tempView = UIView()
        tempView.backgroundColor = .black
        tempView.alpha = 0
        return tempView
    }()
    
    lazy var tableMenu: UITableView = {
        let table = UITableView()
        table.layer.borderWidth = 1
        table.layer.borderColor = CustomColor.customModalBorderColor?.cgColor
        table.layer.cornerRadius = 16
        table.isScrollEnabled = false
        return table
    }()
    
    lazy var btnCancel: UIButton = {
        let btn = UIButton()
        btn.setTitle("Vazgeç", for: .normal)
        btn.titleLabel?.font = .Poppins.semiBold(size: 15).font
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = CustomColor.btnCancelColor
        btn.addTarget(self, action: #selector(handleCloseAction), for: .touchUpInside)
        btn.layer.cornerRadius = 7
        return btn
    }()
    
    var defaultHeight: CGFloat = 250
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    weak var delegate: CustomModalVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableMenu.delegate = self
        tableMenu.dataSource = self
        
        defaultHeight = menuList.count == 0 ? 250 : (CGFloat(menuList.count) * 50.0) + 75
        setupView()
        setupConstraint()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
        
        tableMenu.register(CustomModalTableViewCell.self, forCellReuseIdentifier: "menuCell")
        tableMenu.reloadData()
    }
    
    @objc func handleCloseAction() {
        animateDismissView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func setupConstraint() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        
        containerView.addSubview(contentStackView)
        
        dimmedView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        
        containerView.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: -15, paddingLeading: 15, width: 0, height: 0)
        
        contentStackView.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, paddingTop: 0, paddingBottom: -10, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        
        btnCancel.translatesAutoresizingMaskIntoConstraints = false
        btnCancel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: defaultHeight + 20)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
    }
    
    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func animateShowDimmedView() {
        UIView.animate(withDuration: 0.2) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    func animateDismissView() {
        dimmedView.alpha = self.maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        }
        UIView.animate(withDuration: 0.2) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
}

extension CustomModalVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type: MenuType
        if indexPath.row == 0 {
            type = .montlySummary
        } else if indexPath.row == 1 {
            type = .yearlySummary
        } else if indexPath.row == 2 {
            type = .about
        } else {
            type = .appStore
        }
        
        self.delegate?.didSelect(at: type)
    }
}

extension CustomModalVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableMenu.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? CustomModalTableViewCell else { return UITableViewCell() }
        cell.leftIcon.image = menuList[indexPath.row].image
        cell.lblTitle.text = menuList[indexPath.row].title
        cell.selectionStyle = .none
        return cell
    }
}
