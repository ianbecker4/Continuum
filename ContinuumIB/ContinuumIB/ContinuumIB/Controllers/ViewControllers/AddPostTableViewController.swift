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
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    

    // MARK: - Lifecycle
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        photoImageView.image = nil
        selectPhotoButton.setTitle("Select Photo", for: .normal)
    }
    
    // MARK: - Actions
    @IBAction func selectPhotoButtonTapped(_ sender: Any) {
        
        photoImageView.image = UIImage(named: "spaceEmptyState")
        selectPhotoButton.setTitle("", for: .normal)
    }
    
    @IBAction func addPostButtonTapped(_ sender: Any) {
        
        guard let photo = photoImageView.image,
            let caption = captionTextField.text else {return}
        
        PostController.sharedInstance.createPostWith(photo: photo, caption: caption) { (post) in
            
            self.tabBarController?.selectedIndex = 0
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        self.tabBarController?.selectedIndex = 0
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
} // End of class 
