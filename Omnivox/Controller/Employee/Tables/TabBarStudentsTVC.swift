//
//  TabBarStudentsTVC.swift
//  Omnivox
//
//  Created by english on 2019-07-18.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit

class TabBarStudentsTVC: UITableViewController {
    
    var tableCallback: TableCallback?
    
    var students = [StudentForm]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "StudentCell", bundle: nil), forCellReuseIdentifier: "StudentCell")

        self.refreshControl?.addTarget(self, action: #selector(refreshStudents(_:)), for: .valueChanged)
    }
    
    @objc
    func refreshStudents(_ sender: Any) {
        api.getJsonEntities(withURL: "http://localhost:8080/students") { (response, json) in
            if response.statusCode == 200 {
                self.students.removeAll()
                for student in json {
                    let studentID = student["studentID"] as? String
                    let name = student["name"] as? String
                    let studentForm = StudentForm(studentID: studentID, name: name)
                    self.students.append(studentForm)
                }
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.students.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell") as? StudentCell {
            cell.studentIDLbl.text = self.students[indexPath.row].studentID
            cell.nameLbl.text = self.students[indexPath.row].name
            return cell
        } else {
            return StudentCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableCallback?.didSelectRow(withID: self.students[indexPath.row].studentID!)
    }
}
