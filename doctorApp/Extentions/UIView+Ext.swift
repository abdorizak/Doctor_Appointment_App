//
//  UIView+Ext.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/20/21.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
