//
//  DoctorsListTableViewCell.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/21/21.
//

import UIKit

class DoctorsListTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: DoctorsListTableViewCell.self)
    
    @IBOutlet var doctorImage: UIImageView!
    @IBOutlet var doctorNameLabel: UILabel!
    @IBOutlet var doctorTileLabel: UILabel!
    
    func display(ListOf d: Doctor) {
        guard let dImage = d.image else { return }
        NetworkManager.shared.downloadImage(from: dImage) { [weak self] image in
            DispatchQueue.main.async {
                self?.doctorImage.image = image
            }
        }
        doctorNameLabel.text    = d.name
        doctorTileLabel.text      = d.title
    }
    
    
    func displayCategory(dcotrosIn d: Doctor){
        guard let dImage = d.image else { return }
        NetworkManager.shared.downloadImage(from: dImage) { [weak self] image in
            DispatchQueue.main.async {
                self?.doctorImage.image = image
            }
        }
        doctorNameLabel.text    = d.name
        doctorTileLabel.text      = d.title
    }
}
