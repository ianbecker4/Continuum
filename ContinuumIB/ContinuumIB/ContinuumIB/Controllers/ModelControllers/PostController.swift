//
//  PostController.swift
//  ContinuumIB
//
//  Created by Ian Becker on 8/18/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit


class PostController {
    
    // MARK: - Shared instance
    
    static let sharedInstance = PostController()
    
    // MARK: - Source of truth
    
    var posts: [Post] = []
    
    // MARK: - Methods
    
    func addComment(text: String, post: Post, completion: @escaping (Result<Comment?, PostError>) -> Void) {
        
        let comment = Comment(text: text, postReference: <#CKRecord.Reference?#>)
        
        post.comments.append(comment)
    }
    
    func createPostWith(photo: UIImage, caption: String, completion: @escaping (Result<Post?, PostError>) -> Void) {
        
        let post = Post(caption: caption, photo: photo)
        
        self.posts.append(post)
    }
} // End of class 
