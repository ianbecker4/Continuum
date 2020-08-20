//
//  PostDetailTableViewController.swift
//  ContinuumIB
//
//  Created by Ian Becker on 8/18/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    // MARK: - Properties
    
    var post: Post? {
        
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func commentButtonTapped(_ sender: Any) {
        presentCommentAlertController()
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
        guard let comment = post?.caption else {return}
        
        let shareSheet = UIActivityViewController(activityItems: [comment], applicationActivities: nil)
        
        present(shareSheet, animated: true, completion: nil)
    }
    
    @IBAction func followButtonTapped(_ sender: Any) {
        
        
        
    }
    
    // MARK: - Methods
    @objc func updateViews() {
        
        guard let post = post else {return}
        
        photoImageView.image = post.photo
        tableView.reloadData()
        
    }
    
    func presentCommentAlertController() {
        
        let alertController = UIAlertController(title: "Add a comment", message: "Say something nice!", preferredStyle: .alert)
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Type comment here:"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let commentAction = UIAlertAction(title: "Add comment", style: .default) { (_) in
            
            guard let commentText = alertController.textFields?.first?.text, !commentText.isEmpty,
                let post = self.post else {return}
            
            PostController.sharedInstance.addComment(text: commentText, post: post) { (comment) in
            }
            
            self.tableView.reloadData()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(commentAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.comments.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)

        let comment = post?.comments[indexPath.row]
        
        cell.textLabel?.text = comment?.text
        cell.detailTextLabel?.text = comment?.timestamp.stringWith(dateStyle: .medium, timeStyle: .short)
        
        return cell
    }
} // End of class 
