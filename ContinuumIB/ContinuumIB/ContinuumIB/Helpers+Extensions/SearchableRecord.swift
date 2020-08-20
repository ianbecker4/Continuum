//
//  SearchableRecord.swift
//  ContinuumIB
//
//  Created by Ian Becker on 8/19/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import Foundation

protocol SearchableRecord {
    func matches(searchTerm: String) -> Bool
}
