//
//  Protocols.swift
//  Unit4Assignment1Proj
//
//  Created by Kevin Natera on 10/6/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation


protocol PhotoCellDelegate: AnyObject {
    func showActionSheet(tag: Int)
}

protocol SettingsDelegate : AnyObject {
    func verticalScrollOn()
    func verticalScrollOff()
}

protocol AddPhotoDelegate: AnyObject {
    
}
