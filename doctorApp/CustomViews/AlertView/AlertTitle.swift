//
//  title.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/29/21.
//

import UIKit

class AlertTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTitleLabel()
    }
    
    
    convenience init(textAligment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAligment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTitleLabel() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    

}
