//
//  ViewController.swift
//  Todo-list
//
//  Created by Le Trung on 4/16/19.
//  Copyright © 2019 Le Trung. All rights reserved.
//

import UIKit

let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CanReceive {
    
    var todoList = [ToDo]()
    let cellId = "CellId"
    var timer = Timer()
//    let test = ["Row1", "Row2", "Row3"]
//    let imageName = ["anchor", "arrow-down", "aperture"]
    @IBOutlet weak var ImageTop: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //append first todo item
        todoList.append(ToDo(title: "Work Out", description: "Run 10000 steps", category: "Personal 😄", date: Date()))
        
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        configureTableView()
        ImageTop.image = UIImage(named: "todo-background")
        dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none)
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
    }
    @objc func tick() {
        dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none)
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
    }
    //data source method
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
        cell.categoryLabel?.text = todoList[indexPath.row].title
        cell.descriptionLabel.text = todoList[indexPath.row].description
        var imageCategory = ""
        switch todoList[indexPath.row].category {
        case "Personal 😄":
            imageCategory = "Personal"
            cell.uiButton.backgroundColor =  UIColor(hexString: "#34495e")
        case "Home 🏠":
            imageCategory = "Home"
            cell.uiButton.backgroundColor =  UIColor(hexString: "#1abc9c")
        case "Work 💼":
            imageCategory = "Work"
            cell.uiButton.backgroundColor =  UIColor(hexString: "#e74c3c")
        case "Play 🎮":
            imageCategory = "Play"
            cell.uiButton.backgroundColor =  UIColor(hexString: "#f1c40f")
        case "Health 🏋🏻‍♀️":
            imageCategory = "Health"
            cell.uiButton.backgroundColor =  UIColor(hexString: "#1e3799")
        case "Other":
            imageCategory = "Other"
        default:
            break
        }
        cell.imageCategory?.image = UIImage(named: imageCategory)
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        cell.timeLabel.text = df.string(from: todoList[indexPath.row].date)
        
        return cell
    }
    
    func configureTableView() {
        self.tableView.rowHeight = 80
        self.tableView.separatorStyle = .none
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select row at index \(indexPath.row)")
        print("Row height is: \(tableView.rowHeight)")
       
    }
    
    //Mark: handle add button event and receidata by delegate
    @IBAction func addButtonPressed(_ sender: RoundButton) {
        let addItemViewController = AddItemViewController()
        addItemViewController.delegate = self
        self.present(addItemViewController, animated:true, completion:nil)
    }
    
    func dataReceived(data: ToDo) {
        todoList.append(data)
        tableView.reloadData()
        return
    }
    
    //Mark: Delete item by swiping
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            todoList.remove(at: indexPath.row)
            tableView.reloadData()
            
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            self.tableView.dataSource?.tableView!(self.tableView, commit: .delete, forRowAt: indexPath)
            return
        }
        deleteButton.backgroundColor = UIColor(hexString: "#f8c291")
        return [deleteButton]
    }
}

//extension selecting UIColor by hexcode

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
