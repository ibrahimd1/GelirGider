//
//  CsutomAlertViewController.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 12.11.2022.
//

import Foundation
import UIKit

enum AlertStyle{
    case normal
    case dark
    
    var backgroundColor: UIColor{
        switch self {
        case .normal:
            return UIColor.white
        case .dark:
            return UIColor.black.withAlphaComponent(0.8)
        }
    }
    
    var textColor: UIColor{
        switch self {
        case .normal:
            return UIColor.black
        case .dark:
            return UIColor.white
        }
    }
}

class CustomAlertViewController: UIViewController {
    
    private var alertTitle: String! // Title
    private var message: String! // Message
    private var axis: NSLayoutConstraint.Axis = .horizontal
    private var actions = [Action]()
    private var alertStyle = AlertStyle.normal
    private lazy var backdropView: UIView = {
        let view = createASimpleView(with: UIColor.black.withAlphaComponent(0.0))
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = createSimpleUILabelWith(textColor: alertStyle.textColor, font: UIFont.Poppins.bold(size: 18).font)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = createSimpleUILabelWith(textColor: alertStyle.textColor, font: UIFont.Poppins.medium(size: 15).font)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = createSimpleStackViewWith(axis: .vertical, spacing: 20)
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var actionsStackView: UIStackView = {
        let stackView = createSimpleStackViewWith(axis: self.axis, spacing: 10.0)
        return stackView
    }()
    
    private lazy var containerView: UIView = {
        let view = createASimpleView(with: alertStyle.backgroundColor)
        view.layer.cornerRadius = 10.0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        containerView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        perform(#selector(animateAlert), with: self, afterDelay: 0.01)
        
    }
    
    init(withTitle title: String?, message: String?, actions: [Action], axis: NSLayoutConstraint.Axis, style: AlertStyle = .normal) {
        super.init(nibName: nil, bundle: nil)
        self.actions = actions
        self.alertTitle = title
        self.message = message
        self.axis = axis
        self.alertStyle = style
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func animateAlert() {
        backdropView.alpha = 0.0
        UIView.animate(withDuration: 0.1, animations: {
            self.backdropView.alpha = 1.0
            self.backdropView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self.containerView.transform = .identity
        })
    }
    
    private func setUpUI() {
        view.addSubview(backdropView)
        view.addSubview(containerView)
        containerView.addSubview(titleStackView)
        containerView.addSubview(actionsStackView)
        var containerWidthMultiplier: CGFloat = 0.8
        if UIDevice.current.userInterfaceIdiom == .pad {
            containerWidthMultiplier = 0.4
        }
        
        containerView.anchorCenter(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        titleStackView.anchor(top: containerView.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, paddingTop: 24, paddingBottom: 0, paddingTrailing: -24, paddingLeading: 24, width: 0, height: 0)
        
        backdropView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingTrailing: 0, paddingLeading: 0, width: 0, height: 0)
        
        actionsStackView.anchor(top: titleStackView.bottomAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, paddingTop: 30, paddingBottom: -24, paddingTrailing: -24, paddingLeading: 24, width: 0, height: 0)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: containerWidthMultiplier),
        ])
        
        for action in actions {
            let actionButton = ActionButton(withAction: action)
            actionButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
            actionsStackView.addArrangedSubview(actionButton)
        }
        setUpTitleLabels()
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(messageLabel)
    }
    
    private func setUpTitleLabels() {
        titleLabel.text = alertTitle
        messageLabel.text = message
        
        titleLabel.isHidden = alertTitle != nil ? false : true
        messageLabel.isHidden = message != nil ? false : true
    }
    
    private func createSimpleStackViewWith(axis: NSLayoutConstraint.Axis, spacing: CGFloat = 1) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }
    
    private func createSimpleUILabelWith(textColor: UIColor, font: UIFont) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = textColor
        label.textAlignment = .center
        label.font = font
        return label
    }
    
    private func createASimpleView(with backgroundColor: UIColor = UIColor.white, cornerRadius: CGFloat = 0.0) -> UIView {
        let newView = UIView()
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.backgroundColor = backgroundColor
        newView.layer.cornerRadius = cornerRadius
        return newView
    }
    
}
