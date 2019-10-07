//
//  PhotoPersistenceHelper.swift
//  Unit4Assignment1Proj
//
//  Created by Kevin Natera on 10/6/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation

struct PhotoPersistenceHelper {
    static let manager = PhotoPersistenceHelper()

    func save(newPhoto: Photo) throws {
        try persistenceHelper.save(newElement: newPhoto)
    }

    func getPhotos() throws -> [Photo] {
        return try persistenceHelper.getObjects()
    }
    
    func deletePhoto(withID: Int) throws {
        do {
            let photos = try getPhotos()
            let newPhotos = photos.filter { $0.id != withID }
            try persistenceHelper.replace(elements: newPhotos)
        }
    }

    private let persistenceHelper = PersistenceHelper<Photo>(fileName: "photos.plist")

    private init() {}
}
