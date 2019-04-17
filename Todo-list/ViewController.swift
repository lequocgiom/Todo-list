//
//  ViewController.swift
//  Todo-list
//
//  Created by Le Trung on 4/16/19.
//  Copyright © 2019 Le Trung. All rights reserved.
//

import UIKit

let date = Date()
let calendar = Calendar.current
let hour = calendar.component(.hour, from: date)
let minutes = calendar.component(.minute, from: date)

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "CellId"
    let test = ["Row1", "Row2", "Row3"]
    let imageName = ["anchor", "arrow-down", "aperture"]
    @IBOutlet weak var ImageTop: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        configureTableView()
        ImageTop.image = UIImage(named: "ios-bg")
        
        
    }
    
    //data source method
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
        cell.categoryLabel?.text = test[indexPath.row]
        cell.imageCategory?.image = UIImage(named: imageName[indexPath.row])
        return cell
    }
    
    func configureTableView() {
//        self.tableView.rowHeight = UITableView.automaticDimension
//        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = 80
        self.tableView.separatorStyle = .none
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select row at index \(indexPath.row)")
        print("Row height is: \(tableView.rowHeight)")
    }
}

//extension for formating date

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
