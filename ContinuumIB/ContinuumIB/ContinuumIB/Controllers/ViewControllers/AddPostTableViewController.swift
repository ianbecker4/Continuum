//
//  AddPostTableViewController.swift
//  ContinuumIB
//
//  Created by Ian Becker on 8/18/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var captionTextField: UITextField!
    
    // MARK: - Properties
    var selectedImage: UIImage?
    
    // MARK: - Lifecycle
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        captionTextField.text = nil
    }
    
    // MARK: - Actions
    
    @IBAction func addPostButtonTapped(_ sender: Any) {
        
        guard let selectedImage = selectedImage, let caption = captionTextField.text else {return}
        
        PostController.sharedInstance.createPostWith(photo: selectedImage, caption: caption) { (post) in
            
        }
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoSelectorVC" {
            let photoSelector = segue.destination as? PhotoSelectorViewController
            photoSelector?.delegate = self
        }
    }
} // End of class 

// MARK: - Extensions

extension AddPostTableViewController: PhotoSelectorViewControllerDelegate {
    
    func photoSelectorViewControllerSelected(image: UIImage) {
        selectedImage = image
    }
} // End of extension
