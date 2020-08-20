//
//  Comment.swift
//  ContinuumIB
//
//  Created by Ian Becker on 8/18/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import Foundation
import CloudKit

// MARK: - Strings
struct CommentStrings {
    
    static let recordType = "Comment"
    static let textKey = "text"
    static let timestampKey = "timestamp"
    static let postReferenceKey = "post"
} // End of struct

// MARK: - Model
class Comment {
    
    var text: String
    var timestamp: Date
    let recordID: CKRecord.ID
    var postReference: CKRecord.Reference?
    
    init(text: String, timestamp: Date = Date(), recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), postReference: CKRecord.Reference?) {
        
        self.text = text
        self.timestamp = timestamp
        self.recordID = recordID
        self.postReference = postReference
    }
} // End of class

// MARK: - Extensions

extension CKRecord {
    
    convenience init(comment: Comment) {
        
        self.init(recordType: CommentStrings.recordType, recordID: comment.recordID)
        
        self.setValuesForKeys([
            CommentStrings.textKey : comment.text,
            CommentStrings.timestampKey : comment.timestamp
        ])
        
        if let reference = comment.postReference {
            self.setValue(reference, forKey: CommentStrings.postReferenceKey)
        }
    }
} // End of extension

extension Comment {
    
    convenience init?(ckRecord: CKRecord) {
        guard let text = ckRecord[CommentStrings.textKey] as? String,
            let timestamp = ckRecord[CommentStrings.timestampKey] as? Date else {return nil}
        
        let postReference = ckRecord[CommentStrings.postReferenceKey] as? CKRecord.Reference
        
        self.init(text: text, timestamp: timestamp, recordID: ckRecord.recordID, postReference: postReference)
    }
} // End of extension
