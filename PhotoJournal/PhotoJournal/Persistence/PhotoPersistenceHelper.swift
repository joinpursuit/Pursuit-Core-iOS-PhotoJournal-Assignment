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
    
    private let persistenceHelper = PersistenceHelper<PhotoJournal>(fileName: "PhotoJournal.plist")
    
    func savePhotoEntry(photo: PhotoJournal) throws {
        try persistenceHelper.save(newElement: photo)
    }
    
    func getPhotoJournal() throws -> [PhotoJournal] {
        return try persistenceHelper.getObjects()
    }
    
    func deletePhotoJournal(with tag: Int) throws {
        try persistenceHelper.delete(elementWith: tag)
    }
    
    func editPhotoJournal(at tag: Int, with newElement: PhotoJournal) throws {
        try persistenceHelper.edit(elementWith: tag, newElement: newElement)
    }
    
}
