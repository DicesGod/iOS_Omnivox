//
//  TabBarStudentsVC.swift
//  Omnivox
//
//  Created by english on 2019-07-18.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit

var activeStudentID = ""

class TabBarStudentsVC: UIViewController {
    
    @IBOutlet weak var studentIDTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!

    @IBOutlet weak var container: UIView!
    
    var students = [StudentForm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.refreshTable()
    }
    
    func refreshTable() {
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
                    if let tableVC = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeStudentTable") as? TabBarStudentsTVC {
                        self.addChild(tableVC)
                        tableVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                        tableVC.view.frame = self.container.bounds
                        self.container.addSubview(tableVC.view)
                        tableVC.didMove(toParent: self)
                        tableVC.students = self.students
                        tableVC.tableCallback = self
                    }
                }
            }
        }
    }
    
    @IBAction func addStudentBtn(_ sender: UIButton) {
        let studentForm = StudentForm(studentID: studentIDTF.text, name: nameTF.text)
        api.postJsonEntity(withForm: studentForm) { (response) in
            if response.statusCode == 200 {
                let alert = UIAlertController(title: "Success", message: "Student Saved!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
}

extension TabBarStudentsVC: TableCallback {
    
    func didSelectRow(withID id: String) {
        activeStudentID = id
        performSegue(withIdentifier: "StudentCoursesSegue", sender: self)
    }
}
