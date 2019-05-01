//
//  addItemViewController.swift
//  Todo-list
//
//  Created by Le Trung on 4/18/19.
//  Copyright © 2019 Le Trung. All rights reserved.
//

import Foundation
import Eureka

//Delegate protocol
protocol CanReceive {
    
    func dataReceived(data: ToDo)
    
}
class AddItemViewController : FormViewController {
    
    var todoTitle = ""
    var todoDescription = ""
    var todoCategory  = ""
    var todoDuedate = Date()
    var delegate : CanReceive?
    
//    var todoItem : ToDo?
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section()
            <<< TextRow(){
                $0.title = "Title"
                $0.placeholder = "Enter text here"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                $0.onChange { [unowned self] row in
                    self.todoTitle = row.value ?? "NoTitle"
                }
            }
            <<< TextRow(){
                $0.title = "Description"
                $0.placeholder = "Give some description"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                $0.onChange { [unowned self] row in
                    self.todoDescription = row.value ?? "No Description"
                }
            }
            
            <<< AlertRow<String>() {
                $0.title = "Category"
                $0.selectorTitle = "Select the category"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                $0.options = ["Personal 😄", "Home 🏠", "Work 💼", "Play 🎮", "Health 🏋🏻‍♀️" , "Other"]
                $0.onChange { [unowned self] row in
                    self.todoCategory = row.value ?? "No Category"
                }
                }
            
            
            <<< DateRow() {
                $0.dateFormatter = type(of: self).dateFormatter //1
                $0.title = "Due date" //2
                $0.minimumDate = Date() //4
                $0.value = Date()
                $0.onChange { [unowned self] row in //5
                    if let date = row.value {
                        self.todoDuedate = date
                    }
//                    else {
//                        self.duedate = Date()
//                    }
                }
            }
            // new section for saving button
            +++ Section(){ section in
                section.header = {
                    var header = HeaderFooterView<UIView>(.callback({
                        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
                        button.backgroundColor = .darkGray
                        button.setTitle("Save Item", for: .normal)
                        button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
                        
                        return button
                    }))
                    header.height = { 50 }
                    return header
                }()
        }
    }
    
    //Handle saving and passing data back
    @objc func buttonAction(sender: UIButton!) {
       
        if self.todoTitle == "" {
            let alert = UIAlertController(title: "Missing infomation", message: "TITLE REQUIRED", preferredStyle: .alert)
            let action = UIAlertAction(title: "Cancel", style: .default) { (action) in
                print("Sucess")
            }
            alert.view.tintColor = .red
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
            
        else if self.todoDescription == "" {
            let alert = UIAlertController(title: "Missing infomation", message: "DESCRIPTION REQUIRED", preferredStyle: .alert)
            alert.view.tintColor = .red
            let action = UIAlertAction(title: "Cancel", style: .default) { (action) in
                print("Sucess")
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
            
        else if self.todoCategory == "" {
            let alert = UIAlertController(title: "Missing infomation", message: "CATEGORY REQUIRED", preferredStyle: .alert)
            let action = UIAlertAction(title: "Cancel", style: .default) { (action) in
                print("Sucess")
            }
            alert.view.tintColor = .red
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        else {
        let todoItem = ToDo(title: self.todoTitle, desc: self.todoDescription, cate: self.todoCategory, dueDate: self.todoDuedate)
        delegate?.dataReceived(data: todoItem)
        self.dismiss(animated: true, completion: nil)
//        print(type(of :self.duedate))
//        print(self.duedate)
        print("Button tapped")
        }
    }
}
