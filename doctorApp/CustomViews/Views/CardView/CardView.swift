//
//  CardView.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/20/21.
//

import UIKit

class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        confifure()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        confifure()
    }
    
    private func confifure() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset  = .zero
        layer.cornerRadius  = 10
        layer.shadowOpacity = 0.1
        layer.shadowRadius  = 5
        cornerRadius        = 10
    }
}
