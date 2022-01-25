//
//  CategoryCollectionViewCell.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/20/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: CategoryCollectionViewCell.self)
    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var categoryNameLbl: UILabel!
    
    var categories: DoctorsCategorys?
    
    func display(category: Category) {
        guard let category_Image = category.categoryImage else { return }
        NetworkManager.shared.downloadImage(from: category_Image) { [weak self] image in
            DispatchQueue.main.async {
                self?.categoryImage.image = image
            }
        }
        categoryNameLbl.text = category.categoryName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
