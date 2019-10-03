//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Sunni Tang on 10/2/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class PhotoJournalViewController: UIViewController {

    var photoJournal = [PhotoJournal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadPhotoJournal()
    }

    private func loadPhotoJournal() {
        do {
            photoJournal = try PhotoPersistenceHelper.manager.getPhotoJournal()
        } catch {
            print(error)
        }
    }

}

