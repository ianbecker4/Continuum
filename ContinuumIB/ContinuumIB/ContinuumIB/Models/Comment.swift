//
//  Comment.swift
//  ContinuumIB
//
//  Created by Ian Becker on 8/18/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import Foundation
import CloudKit

class Comment {
    
    var text: String
    var timestamp: Date
    weak var post: Post?
    
    init(text: String, timestamp: Date = Date(), post: Post) {
        
        self.text = text
        self.timestamp = timestamp
        self.post = post
        
    }
} // End of class
