//
//  Todo.swift
//  Todo-list
//
//  Created by Le Trung on 4/18/19.
//  Copyright © 2019 Le Trung. All rights reserved.
//

import Foundation
import RealmSwift

class ToDo: Object{
    @objc dynamic var title = ""
    @objc dynamic var desc = ""
    @objc dynamic var category = ""
    @objc dynamic var dueDate = Date()
    @objc dynamic var hexColor = ""
    @objc dynamic var imageCate = ""
    convenience init(title: String, desc: String, cate: String, dueDate : Date) {
        self.init()
        self.title = title
        self.desc  = desc
        self.category = cate
        self.dueDate = dueDate
        
        switch self.category {
        case "Personal 😄":
            self.imageCate = "Personal"
            self.hexColor = "#34495e"
        case "Home 🏠":
            self.imageCate = "Home"
            self.hexColor = "#1abc9c"
        case "Work 💼":
            self.imageCate = "Work"
            self.hexColor = "#e74c3c"
        case "Play 🎮":
            self.imageCate = "Play"
            self.hexColor = "#f1c40f"
        case "Health 🏋🏻‍♀️":
            self.imageCate = "Health"
            self.hexColor = "#1e3799"
        case "Other":
            self.imageCate = "Other"
            self.hexColor = "#28AAC0"
        default:
        break
        }
        
    }
}
//
//struct ToDo {
//
//    var title: String?
//    var description: String?
//    var category : String?
//    var date : Date
//}
//


//    init(title: String? = nil,
//         description: String? = nil,
//         category: String? = nil
//        ) {
//
//        self.title = title
//        self.description = description
//        self.category = category
//    }
    
