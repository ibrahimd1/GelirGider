//
//  AboutViewController.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 29.01.2023.
//

import UIKit

final class AboutViewController: UIViewController {
    var viewModel: AboutViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.load()
        setupView()
        locateText()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = CustomColor.backgroundColor
        
        let btn = UIBarButtonItem()
        btn.title = "Geri"
        btn.tintColor = CustomColor.textColor
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = btn
    }
    
    fileprivate func locateText() {
        let tempView = getView(imageStr: "calendar", title: "Bu uygulama ile, gelir giderlerinizi, aylık olarak basit ve kullanışlı bir şekilde tutabilirsiniz")
        let tempView1 = getView(imageStr: "info.circle.fill", title: "Kaydetmiş olduğunuz veriler telefonun kendi hafızasında saklanmaktadır")
        let tempView2 = getView(imageStr: "exclamationmark.triangle.fill", title: "Bu yüzden, uygulamayı telefonunuzdan kaldırdığınızda yada uygulama verilerini temizlediğinizde tuttuğunuz veriler kaybolacaktır")
        let tempView3 = getView(imageStr: "text.badge.checkmark", title: "Uygulama ile ilgili görüş,öneri ve isteklerinizi AppStore üzerindeki uygulama yorumlarında belirtebilirsiniz")
        let tempView4 = getView(imageStr: "leaf.fill", title: "Uygulamayı sizin görüş ve önerilerinize göre geliştirmeye devam edeceğiz")
        let tempView5 = getView(imageStr: "star.fill", title: "Bizi puanlamayı unutmayın")
        
        let stackView = UIStackView(arrangedSubviews: [tempView, tempView1, tempView2, tempView3, tempView4, tempView5])
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 15, paddingBottom: 0, paddingTrailing: -16, paddingLeading: 16, width: 0, height: 0)
    }
    
    fileprivate func getView(imageStr: String, title: String) -> UIView {
        let tempView = UIView()
        
        let symbol = UIImage(systemName: imageStr)?.withRenderingMode(.alwaysOriginal)
        let imageView = UIImageView(image: symbol)
        
        tempView.addSubview(imageView)
        imageView.anchor(top: nil, bottom: nil, leading: tempView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 25, height: 25)
        imageView.anchorCenter(centerX: nil, centerY: tempView.centerYAnchor)
        
        let lbl = UILabel()
        lbl.text = title
        lbl.font = .Poppins.medium(size: 14).font
        lbl.textColor = CustomColor.textColor
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        
        tempView.addSubview(lbl)
        lbl.anchor(top: tempView.topAnchor, bottom: tempView.bottomAnchor, leading: imageView.trailingAnchor, trailing: tempView.trailingAnchor, paddingTop: 10, paddingBottom: -10, paddingTrailing: -10, paddingLeading: 10, width: 0, height: 0)
        
        return tempView
    }
}


extension AboutViewController: AboutViewModelDelegate {
    func handleViewModelOutput(_ output: AboutViewModelOutput) {
        switch output {
        case .updateHeader(let title):
            self.title = title
        }
    }
}
