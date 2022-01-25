//
//  TopDoctorsTableViewCell.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 1/9/22.
//

import UIKit

class TopDoctorsTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: TopDoctorsTableViewCell.self)
    
    @IBOutlet var doctorImage: UIImageView!
    @IBOutlet var doctorNameLabel: UILabel!
    @IBOutlet var doctorTileLabel: UILabel!
    
    func display(Top d: Doctor) {
        guard let imageURL = d.image else { return }
        NetworkManager.shared.downloadImage(from: imageURL) { [weak self] image in
            DispatchQueue.main.async {
                self?.doctorImage.image = image
            }
        }
        doctorNameLabel.text    = d.name
        doctorTileLabel.text      = d.title
    }
    
}
