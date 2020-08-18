//
//  Post.swift
//  ContinuumIB
//
//  Created by Ian Becker on 8/18/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit
import CloudKit

class Post {
    
    var photoData: Data?
    var timestamp: Date
    var caption: String
    var comments: [Comment]
    
    var photo: UIImage? {
        
        get {
            guard let photoData = photoData else {return nil}
            return UIImage(data: photoData)
        } set {
            photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    init(timestamp: Date = Date(), caption: String, comments: [Comment] = [], photo: UIImage) {
        
        self.timestamp = timestamp
        self.caption = caption
        self.comments = comments
        self.photo = photo
        
    }
} // End of class
