//
//  UIViewController+Ext.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/29/21.
//

import UIKit

fileprivate var containerView: UIView!


extension UIViewController {
    
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
    }
    
    func presentAlertOnMainThread(title: String, message: String, btnTitle: String) {
        DispatchQueue.main.async {
            let ac = AlertVC(title: title, message: message, buttonTitle: btnTitle)
            ac.modalPresentationStyle = .overFullScreen
            ac.modalTransitionStyle = .crossDissolve
            self.present(ac, animated: true)
        }
    }
    
    func showLoadingview() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8  }
        
        let activatyIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activatyIndicator)
        
        activatyIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activatyIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activatyIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activatyIndicator.startAnimating()
    }
    
    func dismissLoding() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyState(with message: String, in view: UIView) {
        let emptyState = EmptyState(message: message)
        emptyState.frame = view.bounds
        view.addSubview(emptyState)
    }
    
}
