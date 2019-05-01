//
//  Todo.swift
//  Todo-list
//
//  Created by Le Trung on 4/18/19.
//  Copyright © 2019 Le Trung. All rights reserved.
//

import Foundation

class ToDo: Equatable {
    
    var title: String?
    var description: String?
    var dueDate: Date
    
    init(title: String? = nil,
         description: String? = nil,
         dueDate: Date = Date(),
         category: String? = nil
        ) {
        
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.category_raw = category
    }
    
    static func ==(_ lhs: ToDo, _ rhs: ToDo) -> Bool {
        return (lhs.title == rhs.title)
            && (lhs.dueDate == rhs.dueDate)
            && (lhs.category_raw == rhs.category_raw)
    }

}
