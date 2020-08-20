//
//  Post.swift
//  ContinuumIB
//
//  Created by Ian Becker on 8/18/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit
import CloudKit

// MARK: - Strings

struct PostStrings {
    
    static let typeKey = "Post"
    static let captionKey = "caption"
    static let timestampKey = "timestamp"
    static let commentsKey = "comments"
    static let photoKey = "photo"
} // End of struct

// MARK: - Model

class Post {
    
    var timestamp: Date
    var caption: String
    var comments: [Comment]
    var recordID: CKRecord.ID
    var photoData: Data?
    
    var photo: UIImage? {
        
        get {
            guard let photoData = photoData else {return nil}
            return UIImage(data: photoData)
        } set {
            photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    var photoAsset: CKAsset? {
        get {
            guard photoData != nil else {return nil}
            let tempDirectory = NSTemporaryDirectory()
            let tempDirectoryURL = URL(fileURLWithPath: tempDirectory)
            let fileURL = tempDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
            
            do {
                try photoData?.write(to: fileURL)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription)")
            }
            return CKAsset(fileURL: fileURL)
        }
    }
    
    init(timestamp: Date = Date(), caption: String, comments: [Comment] = [], recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), photo: UIImage?) {
        
        self.timestamp = timestamp
        self.caption = caption
        self.comments = comments
        self.recordID = recordID
        self.photo = photo
        
    }
} // End of class

// MARK: - Extensions

extension CKRecord {
    
    convenience init(post: Post) {
        
        self.init(recordType: PostStrings.typeKey, recordID: post.recordID)
        
        self.setValuesForKeys([
            PostStrings.captionKey : post.caption,
            PostStrings.timestampKey : post.timestamp,
            PostStrings.commentsKey : post.comments
        ])
        
        if let postPhoto = post.photoAsset {
            self.setValue(postPhoto, forKey: PostStrings.photoKey)
        }
    }
} // End of extension

extension Post {
    
    convenience init?(ckRecord: CKRecord) {
        guard let caption = ckRecord[PostStrings.captionKey] as? String,
            let timestamp = ckRecord[PostStrings.timestampKey] as? Date,
            let comments = ckRecord[PostStrings.commentsKey] as? [Comment]
            else {return nil}
        
        var foundPhoto: UIImage?
        
        if let photoAsset = ckRecord[PostStrings.photoKey] as? CKAsset {
            do {
                guard let url = photoAsset.fileURL else {return nil}
                let data = try Data(contentsOf: url)
                foundPhoto = UIImage(data: data)
            } catch {
                print("Could not transform asset to data.")
            }
        }
        self.init(timestamp: timestamp, caption: caption, comments: comments, recordID: ckRecord.recordID, photo: foundPhoto)
    }
} // End of extension

extension Post: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        if caption.lowercased().contains(searchTerm.lowercased()) {
            return true
        } else {
            return false
        }
    }
} // End of extension
