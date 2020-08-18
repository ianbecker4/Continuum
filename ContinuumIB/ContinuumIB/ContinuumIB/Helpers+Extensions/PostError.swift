//
//  PostError.swift
//  ContinuumIB
//
//  Created by Ian Becker on 8/18/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import Foundation

enum PostError: LocalizedError {
    
    case ckError(Error)
    case noREcord
    case noPost
    
    var localizedDescription: String {
        switch self {
        case .ckError(let error):
            return "There was an error returned from CloudKit. Error: \(error)."
        case .noREcord:
            return "No record was returned from CloudKit."
        case .noPost:
            return "The post was not found."
        }
    }
    
    
}
