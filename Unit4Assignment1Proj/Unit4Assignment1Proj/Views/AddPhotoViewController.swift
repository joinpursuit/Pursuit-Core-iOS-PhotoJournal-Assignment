//
//  AddPhotoViewController.swift
//  Unit4Assignment1Proj
//
//  Created by Kevin Natera on 10/6/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit
import Photos

class AddPhotoViewController: UIViewController {

    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var cancelButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var saveButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var photoLibraryButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var camerabuttonOutlet: UIBarButtonItem!
    
    weak var delegate : AddPhotoDelegate?
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        photoTitle = titleTextView.text
        caption = captionTextView.text
        
        if photoTitle != "" && imageName != "" && photoToBeEdited == nil {
            let newPhoto = Photo(title: photoTitle, caption: caption, imageName: imageName, date: Date())
                DispatchQueue.global(qos: .utility).async {
                    try? PhotoPersistenceHelper.manager.save(newPhoto: newPhoto)
                }
                self.dismiss(animated: true, completion: nil)
        }
        
        if photoToBeEdited != nil {
            
            let newPhoto = Photo(title: photoTitle, caption: caption, imageName: imageName, date: photoToBeEdited.date)
            
            photos[photoIndex] = newPhoto
            
            DispatchQueue.global(qos: .utility).async {
                try? PhotoPersistenceHelper.manager.edit(newPhotoArray: self.photos)
            }
            
            self.dismiss(animated:true, completion: nil)
           
        }
        }
       
    @IBAction func photoLibraryButtonPressed(_ sender: UIBarButtonItem) {
        let imagePickerViewController = UIImagePickerController()
            imagePickerViewController.delegate = self
            imagePickerViewController.sourceType = .photoLibrary
        present(imagePickerViewController, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        let imagePickerViewController = UIImagePickerController()
            imagePickerViewController.delegate = self
            imagePickerViewController.sourceType = .camera
        present(imagePickerViewController, animated: true, completion: nil)
    }
    
    var photoToBeEdited: Photo!
      
    var photoIndex = Int()
    var photos = [Photo]()
    var photoTitle = ""
    var caption = ""
    var imageName = "" {
        didSet {
            print(imageName)
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if photoToBeEdited == nil {
            setUpNewPost()
        } else {
            let path = getDocumentsDirectory().appendingPathComponent(photoToBeEdited.imageName)
            imageOutlet.image = UIImage(contentsOfFile: path.path)
            titleTextView.text = photoToBeEdited.title
            photoTitle = photoToBeEdited.title
            captionTextView.text = photoToBeEdited.caption
            caption = photoToBeEdited.caption
        }
    }
    
    private func setUpNewPost() {
        imageOutlet.image = UIImage(named: "default")
        titleTextView.text = "Enter title here..."
        titleTextView.textColor = .lightGray
        captionTextView.text = "Enter caption here..."
        captionTextView.textColor = .lightGray
        titleTextView.delegate = self
        captionTextView.delegate = self
    }

    
}

extension AddPhotoViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        photoTitle = titleTextView.text
        caption = captionTextView.text
    }
   
}

extension AddPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        self.imageOutlet.image = image
        
        let imageName = UUID().uuidString
        self.imageName = imageName
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
               try? jpegData.write(to: imagePath)
           }
        
        dismiss(animated: true, completion: nil)
    }
}

public func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
