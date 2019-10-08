//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Sunni Tang on 10/2/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class PhotoJournalViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var photoJournalCollectionView: UICollectionView!
    
    // MARK: - Internal Properties
    var verticalScrollDirection = true {
        didSet {
            UserDefaultsWrapper.manager.store(scrollDirection: verticalScrollDirection)
        }
    }
    var darkModeIsOn = false {
        didSet {
            UserDefaultsWrapper.manager.store(darkMode: darkModeIsOn)
        }
    }

    var photoJournal = [PhotoJournal]() {
        didSet {
            photoJournalCollectionView.reloadData()
        }
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        loadUserDefaults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadPhotoJournal()
    }

    // MARK: - IBActions
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let settingsVC = storyboard.instantiateViewController(identifier: "SettingsVC") as! SettingsViewController
        self.navigationController?.pushViewController(settingsVC, animated: true)
        
        settingsVC.delegate = self
        settingsVC.isVerticalScroll = verticalScrollDirection
        settingsVC.darkModeOn = darkModeIsOn
    }
    
    // MARK: - Private Methods
    private func configureCollectionView() {
        photoJournalCollectionView.dataSource = self
    }
    
    private func loadPhotoJournal() {
        do {
            photoJournal = try PhotoPersistenceHelper.manager.getPhotoJournal()
        } catch {
            let alertVC = UIAlertController(title: "Error", message: "Could not load photo journal!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
    }
    
    private func loadUserDefaults() {
        if let shouldDarkMode = UserDefaultsWrapper.manager.getColorMode() {
            darkModeIsOn = shouldDarkMode
        }
        
        if let shouldVerticalScroll = UserDefaultsWrapper.manager.getScrollDirection() {
            verticalScrollDirection = shouldVerticalScroll
        }
    }

}

// MARK: - CollectionView Delegate Methods
extension PhotoJournalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoJournal.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoJournalCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoJournalCollectionViewCell
        let currentPhotoEntry = photoJournal[indexPath.row]
        
        cell.photoImageView.image = UIImage(data: currentPhotoEntry.photoData)
        cell.titleLabel.text = currentPhotoEntry.title
        cell.dateLabel.text = currentPhotoEntry.date
        
        cell.optionsButton.tag = indexPath.row
        cell.delegate = self
        
        return cell
    }
}

// MARK: - PhotoCell Delegate Methods
extension PhotoJournalViewController: PhotoCellDelegate {
    func showActionSheet(tag: Int) {
        let selectedPhoto = self.photoJournal[tag]
        
        let optionsMenu = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction.init(title: "Delete", style: .destructive) { (action) in
            do {
                try PhotoPersistenceHelper.manager.deletePhotoJournal(with: tag)
                self.loadPhotoJournal()
            } catch {
                let alertVC = UIAlertController(title: "Error", message: "Could not delete photo entry!", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
            }
            
        }
        
        let editAction = UIAlertAction.init(title: "Edit", style: .default) { (action) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editVC = storyboard.instantiateViewController(identifier: "editPhotoSB") as EditPhotoViewController
            self.navigationController?.pushViewController(editVC, animated: true)
            
            editVC.currentPhotoEntry = selectedPhoto
            editVC.currentTag = tag
    
        }
        
        let shareAction = UIAlertAction.init(title: "Share", style: .default) { (action) in
            if let photo = UIImage(data: self.photoJournal[tag].photoData) {
            let activityVC = UIActivityViewController(activityItems: [photo, self.photoJournal[tag].title], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
            }
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        
        optionsMenu.addAction(deleteAction)
        optionsMenu.addAction(editAction)
        optionsMenu.addAction(shareAction)
        optionsMenu.addAction(cancelAction)
        
        present(optionsMenu, animated: true, completion: nil)
        
    }
}

// MARK: - Settings Delegate Methods
extension PhotoJournalViewController: SettingsDelegate, UICollectionViewDelegateFlowLayout {
    func setVerticalScroll() {
        self.verticalScrollDirection = true
        
        if let flowLayout = photoJournalCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
    }
    
    func setHorizontalScroll() {
        self.verticalScrollDirection = false
        
        if let flowLayout = photoJournalCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .horizontal
            }
    }
    
    func darkModeOn() {
        self.photoJournalCollectionView.backgroundColor = .black
        self.darkModeIsOn = true
    }
    
    func darkModeOff() {
        self.photoJournalCollectionView.backgroundColor = .lightGray
        self.darkModeIsOn = false
    }
    
}

