//
//  UserDefaultsWrapper.swift
//  PhotoJournal
//
//  Created by Sunni Tang on 10/7/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

class UserDefaultsWrapper {
    
    // MARK: - Static Properties
    static let manager = UserDefaultsWrapper()
    
    // MARK: - Internal getter methods
    func getScrollDirection() -> Bool? {
        return UserDefaults.standard.value(forKey: scrollDirectionKey) as? Bool
    }
    
    func getColorMode() -> Bool? {
        return UserDefaults.standard.value(forKey: darkModeKey) as? Bool
    }

    
    // MARK: - Internal setter methods
    func store(scrollDirection: Bool) {
        UserDefaults.standard.set(scrollDirection, forKey: scrollDirectionKey)
    }
    
    func store(darkMode: Bool) {
        UserDefaults.standard.set(darkMode, forKey: darkModeKey)
    }
    
    
    // MARK: - Private Properties
    private let scrollDirectionKey = "scrollDirection"
    private let darkModeKey = "darkMode"
    
    // MARK: - Private inits
    private init() {}
}

