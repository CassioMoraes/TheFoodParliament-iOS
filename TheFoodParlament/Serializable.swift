//
//  Serializable.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 14/03/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import Foundation

protocol Serializable {
    associatedtype T
    init()
    func save(data: T)
    func load()
}
