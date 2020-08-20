//
//  PhotoSelectorViewController.swift
//  ContinuumIB
//
//  Created by Ian Becker on 8/19/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit

protocol PhotoSelectorViewControllerDelegate: AnyObject {
    func photoSelectorViewControllerSelected(image: UIImage)
}

class PhotoSelectorViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    
    // MARK: - Properties
    weak var delegate: PhotoSelectorViewControllerDelegate?

    // MARK: - Lifecycle
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        photoImageView.image = nil
        selectPhotoButton.setTitle("Select Photo", for: .normal)
    }
    
    // MARK: - Actions
    @IBAction func selectPhotoButtonTapped(_ sender: Any) {
        presentImagePickerActionSheet()
    }
} // End of class

// MARK: - Extension
extension PhotoSelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        
            selectPhotoButton.setTitle("", for: .normal)
            photoImageView.image = selectedImage
            delegate?.photoSelectorViewControllerSelected(image: selectedImage)
        }
    }
    
    func presentImagePickerActionSheet() {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Select Photo", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { (_) in
                
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                
                imagePickerController.sourceType = UIImagePickerController.SourceType.camera
                
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
} // End of extension
