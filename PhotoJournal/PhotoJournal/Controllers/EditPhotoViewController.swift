//
//  EditPhotoViewController.swift
//  PhotoJournal
//
//  Created by Sunni Tang on 10/3/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class EditPhotoViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func savePhotoButtonPressed(_ sender: UIButton) {
//        guard let imageData = self.photoImageView.image?.jpegData(compressionQuality: 0.5) else { return }
//                 let photoInfo = PhotoJournal(id: <#T##Int#>, photoData: imageData, title: <#T##String#>, date: <#T##String#>)
//
//
//                 try? PhotoPersistenceHelper.manager.saveProfileImage(info: profileImageInfo)
    }
    
    @IBAction func addPhotoFromLibraryButtonPressed(_ sender: UIButton) {
        let imagePickerViewController = UIImagePickerController()
             imagePickerViewController.delegate = self
             imagePickerViewController.sourceType = .photoLibrary
        
        present(imagePickerViewController, animated: true)
    }
    
   
}

extension EditPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            photoImageView.image = image
        } else {
            print("No original image")
            
        }
        
        dismiss(animated: true, completion: nil)
            
        
    }
}
