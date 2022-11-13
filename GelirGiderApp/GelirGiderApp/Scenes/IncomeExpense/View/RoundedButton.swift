//
//  RoundedButton.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 2.04.2022.
//

import Foundation
import UIKit

internal final class RoundedButton: UIButton {
    
    fileprivate var titleColor: UIColor?
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.font = .Poppins.medium(size: 13).font
        return lbl
    }()
    
    private lazy var icon: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(title)
        self.addSubview(icon)
        
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = CustomColor.borderColor?.cgColor
    }
    
    func configure (with viewmodel: RoundedButtonViewModel) {
        title.text = viewmodel.text
        icon.image = viewmodel.icon
        self.backgroundColor = viewmodel.backgroundColor
        self.titleColor = viewmodel.titleColor
        self.title.textColor = self.titleColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.title.sizeToFit()
        setupViews()
    }
    
    override var isHighlighted: Bool {
        didSet {
            guard let color = self.titleColor else { return }
            if isHighlighted {
                self.title.textColor = color.withAlphaComponent(0.6)
            } else {
                self.title.textColor = color
            }
        }
    }
    
    private func setupViews() {
        let iconSize: CGFloat = 18
        let iconX = (self.frame.size.width - title.frame.size.width - iconSize - 25) / 2
        let iconY = (self.frame.size.height - iconSize) / 2
        
        icon.frame = CGRect(x: iconX, y: iconY, width: iconSize, height: iconSize)
        title.frame = CGRect(x: iconX + iconSize + 15, y: 0, width: title.frame.size.width, height: self.frame.size.height)
    }
}

struct RoundedButtonViewModel {
    let text: String
    let icon: UIImage
    let titleColor: UIColor
    let backgroundColor: UIColor
}
