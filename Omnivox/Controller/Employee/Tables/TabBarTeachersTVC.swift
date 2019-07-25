//
//  TabBarTeachersTVC.swift
//  Omnivox
//
//  Created by english on 2019-07-22.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit

class TabBarTeachersTVC: UITableViewController {
    
    var tableCallback: TableCallback?

    var teachers = [TeacherForm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "TeacherCell", bundle: nil), forCellReuseIdentifier: "TeacherCell")
        
        self.refreshControl?.addTarget(self, action: #selector(refreshTeachers(_:)), for: .valueChanged)
    }
    
    @objc
    func refreshTeachers(_ sender: Any) {
        api.getJsonEntities(withURL: "http://localhost:8080/teachers") { (response, json) in
            if response.statusCode == 200 {
                self.teachers.removeAll()
                for teacher in json {
                    let teacherID = teacher["teacherID"] as? String
                    let name = teacher["name"] as? String
                    let teacherForm = TeacherForm(teacherID: teacherID, name: name)
                    self.teachers.append(teacherForm)
                }
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teachers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherCell") as? TeacherCell {
            cell.teacherIDLbl.text = self.teachers[indexPath.row].teacherID
            cell.nameLbl.text = self.teachers[indexPath.row].name
            return cell
        } else {
            return TeacherCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableCallback?.didSelectRow(withID: self.teachers[indexPath.row].teacherID)
    }
}
