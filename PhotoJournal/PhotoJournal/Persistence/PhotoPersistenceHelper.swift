//
//  PhotoPersistenceHelper.swift
//  PhotoJournal
//
//  Created by Sunni Tang on 10/3/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct PhotoPersistenceHelper {
    private init() {}
    
    static let manager = PhotoPersistenceHelper()
    
    private let persistenceHelper = PersistenceHelper<Photo>(fileName: "photos.plist")
    
    func saveFilm(photo: Photo) throws {
        try persistenceHelper.save(newElement: photo)
    }
    
    func getFilms() throws -> [Photo] {
        return try persistenceHelper.getObjects()
    }
    
}
