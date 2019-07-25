//
//  TabBarTeachersVC.swift
//  Omnivox
//
//  Created by english on 2019-07-18.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit

var activeTeacherID = ""

class TabBarTeachersVC: UIViewController {
    
    @IBOutlet weak var teacherIDTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var container: UIView!
    
    var teachers = [TeacherForm]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.refreshTable()
    }

    func refreshTable() {
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
                    if let tableVC = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeTeacherTable") as? TabBarTeachersTVC {
                        self.addChild(tableVC)
                        tableVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                        tableVC.view.frame = self.container.bounds
                        self.container.addSubview(tableVC.view)
                        tableVC.didMove(toParent: self)
                        tableVC.teachers = self.teachers
                        tableVC.tableCallback = self
                    }
                }
            }
        }
    }
    
    @IBAction func addTeacherBtn(_ sender: UIButton) {
        let teacherForm = TeacherForm(teacherID: teacherIDTF.text, name: nameTF.text)
        api.postJsonEntity(withForm: teacherForm) { (response) in
            if response.statusCode == 200 {
                let alert = UIAlertController(title: "Success", message: "Teacher Saved!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
}

extension TabBarTeachersVC: TableCallback {
    
    func didSelectRow(withID id: String) {
        activeTeacherID = id
        performSegue(withIdentifier: "TeacherCoursesSegue", sender: self)
    }
}
