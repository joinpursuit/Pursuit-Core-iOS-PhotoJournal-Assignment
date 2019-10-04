//
//  EditPhotoViewController.swift
//  PhotoJournal
//
//  Created by Sunni Tang on 10/3/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class EditPhotoViewController: UIViewController {

    // To do - figure out textview and test persistence in save button
    
    @IBOutlet weak var titleTextView: UITextView!
    
    @IBOutlet weak var photoImageView: UIImageView!
    private var imagePickerViewController = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
        configureImagePicker()
        configureStockImage()
    }
    
    @IBAction func savePhotoButtonPressed(_ sender: UIButton) {
        
        guard let imageData = self.photoImageView.image?.jpegData(compressionQuality: 0.5) else { return }
        let photoInfo = PhotoJournal(photoData: imageData, title:
            titleTextView.text, date: Date.init().description)

        try? PhotoPersistenceHelper.manager.savePhotoEntry(photo: photoInfo)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func addPhotoFromLibraryButtonPressed(_ sender: UIButton) {
        imagePickerViewController.sourceType = .photoLibrary
        
        present(imagePickerViewController, animated: true)
        
    }
    
    private func configureStockImage() {
        photoImageView.image = UIImage(named: "noImage")
        photoImageView.backgroundColor = .lightGray
    }
    
    private func configureImagePicker() {
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
    }

    private func configureTextView() {
        titleTextView.delegate = self
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

extension EditPhotoViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
       
    }
    
}
