//
//  SearchCell.swift
//  FlickerSearchApp
//
//  Created by casandra grullon on 1/7/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var photo: Photo?
    
    func configureCell(for photo: Photo){
        nameLabel.text = photo.title
        photoImage.getImage(with: photo.imageURL) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.photoImage.image = UIImage(systemName: "square.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.photoImage.image = image
                }
            }
        }
    }
    
}
