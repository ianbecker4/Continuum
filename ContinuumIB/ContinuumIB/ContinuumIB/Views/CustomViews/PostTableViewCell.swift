//
//  PostTableViewCell.swift
//  ContinuumIB
//
//  Created by Ian Becker on 8/18/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var postPhotoImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    
    // MARK: - Properties
    var post: Post? {
        
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Methods
    func updateViews() {
        
        postPhotoImageView.image = post?.photo
        captionLabel.text = post?.caption
        commentCountLabel.text = "Comments: \(post?.comments.count ?? 0)"
        
    }
}
