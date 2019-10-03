//
//  Photo.swift
//  PhotoJournal
//
//  Created by Sunni Tang on 10/3/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct PhotoJournal: Codable {
    let photoData: Data
    let title: String
    let date: String 
}
