//
//  ActionButton.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 12.11.2022.
//

import Foundation
import UIKit

class ActionButton: UIButton {
    private var actionHandler: (() -> Void)!

    init(withAction action: Action) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.actionHandler = action.actionHandler
        self.setUpButtonWith(action: action)
    }

    private func setUpButtonWith(action: Action) {
        self.titleLabel?.font = UIFont.Poppins.bold(size: 15).font
        self.setTitle(action.title, for: .normal)
        self.layer.cornerRadius = 5
        addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        self.setUpUIForStyle(style: action.style)
    }

    private func setUpUIForStyle(style: ActionStyle) {
        self.backgroundColor = UIColor.systemBlue
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: .highlighted)
    }

    @objc func didTapButton() {
        self.actionHandler?()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
