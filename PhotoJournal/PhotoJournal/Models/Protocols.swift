//
//  Protocols.swift
//  PhotoJournal
//
//  Created by Sunni Tang on 10/4/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoCellDelegate: AnyObject {
    func showActionSheet(tag: Int)
}

protocol SettingsDelegate: AnyObject {
    func setVerticalScroll()
    func setHorizontalScroll()

    func darkModeOn()
    func darkModeOff()
}
