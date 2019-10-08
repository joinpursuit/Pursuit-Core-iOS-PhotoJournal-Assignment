//
//  EditPhotoViewController.swift
//  PhotoJournal
//
//  Created by Sunni Tang on 10/3/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class EditPhotoViewController: UIViewController {

    // TODO: Set up permissions for library and camera
    // TODO: Add functionality to camera button
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoLibraryButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Internal Properties
    var currentPhotoEntry: PhotoJournal? = nil
    var currentTag: Int? = nil
    
    private var imagePickerViewController = UIImagePickerController()
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if currentPhotoEntry != nil {
            loadCurrentEntry()
            photoLibraryButton.isEnabled = false
            cameraButton.isEnabled = false
        } else {
            loadEmptyEntry()
        }
        configureImagePicker()
    }
    
    // MARK: - IBActions
    @IBAction func savePhotoButtonPressed(_ sender: UIButton) {
        // TODO: - Add functionality to save over edited photo instead of creating new entry
        guard let imageData = self.photoImageView.image?.jpegData(compressionQuality: 0.5) else { return }
        
        if currentPhotoEntry == nil {
            let newPhotoInfo = PhotoJournal(photoData: imageData, title:
                      titleTextView.text, date: Date.init().description)

            try? PhotoPersistenceHelper.manager.savePhotoEntry(photo: newPhotoInfo)
        } else {
            if let currentPhotoEntry = currentPhotoEntry, let currentTag = currentTag {
                let editedPhotoInfo = PhotoJournal(photoData: currentPhotoEntry.photoData, title:
                    titleTextView.text, date: currentPhotoEntry.date)
                
                try? PhotoPersistenceHelper.manager.editPhotoJournal(at: currentTag, with: editedPhotoInfo)
            }
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func addPhotoFromLibraryButtonPressed(_ sender: UIButton) {
        imagePickerViewController.sourceType = .photoLibrary
        
        present(imagePickerViewController, animated: true)
        
        saveButton.isEnabled = true
        
    }
    
    // MARK: - Private Methods
    private func loadEmptyEntry() {
        titleTextView.delegate = self
        titleTextView.textColor = .lightGray
        
        photoImageView.image = UIImage(named: "noImage")
        photoImageView.backgroundColor = .lightGray

        saveButton.isEnabled = false
    }
    
    private func configureImagePicker() {
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
    }
    
    private func loadCurrentEntry() {
        titleTextView.text = currentPhotoEntry?.title
        photoImageView.image = UIImage(data: currentPhotoEntry!.photoData)
        photoImageView.backgroundColor = .lightGray
    }
   
}

// MARK: - ImagePicker Delegate Methods
extension EditPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            photoImageView.image = image
        } else {
            let alertVC = UIAlertController(title: "Error", message: "Could not load image picker!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
        dismiss(animated: true, completion: nil)
        
    }
}

// MARK: - TextView Delegate Methods
extension EditPhotoViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        titleTextView.text = ""
        titleTextView.textColor = .black
    }
}
