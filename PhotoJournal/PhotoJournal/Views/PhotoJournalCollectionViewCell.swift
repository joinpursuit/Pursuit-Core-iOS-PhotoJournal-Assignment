//
//  PhotoJournalCollectionViewCell.swift
//  PhotoJournal
//
//  Created by Sunni Tang on 10/3/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class PhotoJournalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var optionsButton: UIButton!
    
    weak var delegate: PhotoCellDelegate?
    
    @IBAction func optionsButtonPressed(_ sender: UIButton) {
        delegate?.showActionSheet(tag: sender.tag)
    }
    
    
}
