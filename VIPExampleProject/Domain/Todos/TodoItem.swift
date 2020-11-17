//
//  TodoItem.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 9/25/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import Foundation

struct TodoItem: Equatable {
    
    let id: UUID
    var title: String
    var done: Bool
    
    init(title: String) {
        id = UUID()
        self.title = title
        done = false
    }
    
    init(id: UUID, title: String, done: Bool) {
        self.id = id
        self.title = title
        self.done = done
    }
}

extension TodoItem {
    
    mutating func finalize() {
        done.toggle()
    }
}
