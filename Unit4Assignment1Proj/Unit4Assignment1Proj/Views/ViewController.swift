//
//  ViewController.swift
//  Unit4Assignment1Proj
//
//  Created by Kevin Natera on 10/4/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var photoCollectionOutlet: UICollectionView!
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    var photos = [Photo]() {
        didSet {
            photoCollectionOutlet.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProtocols()
    }
    
    private func setUpProtocols() {
        photoCollectionOutlet.delegate = self
        photoCollectionOutlet.dataSource = self
    }
    
    var bs = ["1","2","3"]
    var desc = ["something about this boi","some other thang", "yeeeeeerrrrrrR"]
    
}


// MARK: - CollectionView Extensions

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollectionOutlet.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! PhotoCollectionViewCell
        cell.titleLabel.text = bs[indexPath.row]
        cell.captionLabel.text = desc[indexPath.row]
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
            //favorite using persistence
//            let film = self.films[tag] //refactor this with photos
//            print("My favorite film is \(film.title)")
            print("edit")
        }
        
        let deleteAction = UIAlertAction.init(title: "Delete", style: .destructive) { (action) in
            //delete using persistence
//            let film = self.films[tag]
//            print("I just deleted \(film.title)")
            print("delete")
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
