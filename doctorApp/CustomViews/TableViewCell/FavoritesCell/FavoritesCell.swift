//
//  FavoritesCell.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/30/21.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    static let identifier = String(describing: FavoritesCell.self)
    @IBOutlet var doctorImage: UIImageView!
    @IBOutlet var doctorName: UILabel!
    @IBOutlet var doctorTitle: UILabel!
    
    // displaying Func
    func display(Favorite d: Doctor) {
        NetworkManager.shared.downloadImage(from: d.image ?? "nil") { [weak self] image in
            DispatchQueue.main.async {
                self?.doctorImage.image = image
            }
        }
        doctorName.text = d.name
        doctorTitle.text = d.title
    }
    
}
