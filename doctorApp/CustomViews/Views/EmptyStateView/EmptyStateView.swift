//
//  View.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/29/21.
//

import UIKit

// Empty State
class EmptyState: UIView {
    
    let messageLabel = AlertTitleLabel(textAligment: .center, fontSize: 28)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureEmptyState()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureEmptyState()
    }
    
    init(message: String){
        super.init(frame: .zero)
        self.messageLabel.text = message
        configureEmptyState()
    }
    
    func configureEmptyState() {
        addSubview(messageLabel)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
}



