//
//  ViewController.swift
//  Unit4Assignment1Proj
//
//  Created by Kevin Natera on 10/4/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var photoCollectionOutlet: UICollectionView!
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let addPhotoVC = storyBoard.instantiateViewController(identifier: "AddPhotoViewController") as! AddPhotoViewController
        self.present(addPhotoVC, animated: true, completion: nil)
        addPhotoVC.delegate = self
        addPhotoVC.darkModeEnabled = darkMode
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let settingsVC = storyBoard.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(settingsVC, animated: true)
        settingsVC.delegate = self
        settingsVC.verticalScroll = verticalScroll
        settingsVC.darkModeisOn = darkMode
    }
    
    
    var photos = [Photo]() {
        didSet {
            DispatchQueue.main.async {
                self.loadData()
            }
        }
    }
    
    var verticalScroll = true
    var darkMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProtocols()
        loadData()
        loadDefaults()
        
    }


    private func setUpProtocols() {
        photoCollectionOutlet.delegate = self
        photoCollectionOutlet.dataSource = self
    }
  
    private func loadData() {
        do {
            photos = try PhotoPersistenceHelper.manager.getPhotos()
           } catch {
               print(error)
            }
        photoCollectionOutlet.reloadData()
    }
    
    private func loadDefaults() {
        if let userScroll = UserDefaults.standard.value(forKey: "VerticalScroll") as? Bool {
            if userScroll {
                verticalScrollOn()
            } else {
                verticalScrollOff()
            }
        }
        if let userMode = UserDefaults.standard.value(forKey: "DarkMode") as? Bool {
            if userMode {
                darkModeOn()
            } else {
                darkModeOff()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? PhotoCollectionViewCell, let indexPath = self.photoCollectionOutlet.indexPath(for: cell) {
         let addPhotoVC = segue.destination as! AddPhotoViewController
            
            addPhotoVC.photoToBeEdited = photos[indexPath.row]
    }
    }
}
    
    

// MARK: - CollectionView Extensions

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = photoCollectionOutlet.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! PhotoCollectionViewCell
        
        let photo = photos[indexPath.row]
        cell.configureCell(photo: photo)
        cell.delegate = self
        cell.optionButtonOutlet.tag = indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 350)
    }
    
}

// MARK: - Alert Controller

extension ViewController : PhotoCellDelegate {
    
    func showActionSheet(tag: Int) {
        let optionsMenu = UIAlertController.init(title: "Options", message: "Pick an action", preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction.init(title: "Edit", style: .default) { (action) in
            let photo = self.photos[tag]
            
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let addPhotoVC = storyBoard.instantiateViewController(identifier: "AddPhotoViewController") as! AddPhotoViewController
            addPhotoVC.photoToBeEdited = photo
            addPhotoVC.photoIndex = tag
            addPhotoVC.imageName = photo.imageName
            addPhotoVC.photos = self.photos
            addPhotoVC.modalPresentationStyle = .currentContext
            self.present(addPhotoVC, animated: true, completion: nil)
        }
        
        let deleteAction = UIAlertAction.init(title: "Delete", style: .destructive) { (action) in
            let photo = self.photos[tag]
            DispatchQueue.global(qos: .utility).async {
                 try? PhotoPersistenceHelper.manager.deletePhoto(withDate: photo.date)
            }
        }
        
        let shareAction = UIAlertAction.init(title: "Share", style: .default) { (action) in
            print("share")
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        
        optionsMenu.addAction(editAction)
        optionsMenu.addAction(shareAction)
        optionsMenu.addAction(deleteAction)
        optionsMenu.addAction(cancelAction)
        
        present(optionsMenu, animated: true, completion: nil)
    }
}

extension ViewController : SettingsDelegate {
   
    func darkModeOn() {
        darkMode = true
        view.backgroundColor = .black
        
    }
    
    func darkModeOff() {
        darkMode = false
        view.backgroundColor = .white
    }
    
    func verticalScrollOn() {
        let layout = photoCollectionOutlet.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        verticalScroll = true
        
    }
    
    func verticalScrollOff() {
        let layout = photoCollectionOutlet.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        verticalScroll = false
    }
    
   
    
    
   
}

extension ViewController : AddPhotoDelegate {
    
}
