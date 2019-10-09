//
//  PhotoCollectionViewCell.swift
//  Unit4Assignment1Proj
//
//  Created by Kevin Natera on 10/6/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var optionButtonOutlet: UIButton!
    
    @IBAction func optionButtonPressed(_ sender: UIButton) {
        delegate?.showActionSheet(tag: sender.tag)
    }
    
    
    weak var delegate : PhotoCellDelegate?
    
    func configureCell(photo: Photo) {
        titleLabel.text = photo.title
        captionLabel.text = photo.caption
        let path = getDocumentsDirectory().appendingPathComponent(photo.imageName)
        imageOutlet.image = UIImage(contentsOfFile: path.path)
    }
}
