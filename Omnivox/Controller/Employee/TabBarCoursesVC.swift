//
//  TabBarCoursesVC.swift
//  Omnivox
//
//  Created by english on 2019-07-18.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit

class TabBarCoursesVC: UIViewController {
    
    @IBOutlet weak var courseIDTF: UITextField!
    @IBOutlet weak var courseTitleTF: UITextField!
    @IBOutlet weak var creditsTF: UITextField!

    @IBOutlet weak var container: UIView!

    var courses = [CourseForm]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.refreshTable()
    }

    func refreshTable() {
        api.getJsonEntities(withURL: "http://localhost:8080/courses") { (response, json) in
            if response.statusCode == 200 {
                self.courses.removeAll()
                for course in json {
                    let courseID = course["courseID"] as? String
                    let courseTitle = course["courseTitle"] as? String
                    let credits = course["credits"] as? Int
                    let courseForm = CourseForm(courseID: courseID, courseTitle: courseTitle, credits: credits)
                    self.courses.append(courseForm)
                }
                DispatchQueue.main.async {
                    if let tableVC = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeCourseTable") as? TabBarCoursesTVC {
                        self.addChild(tableVC)
                        tableVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                        tableVC.view.frame = self.container.bounds
                        self.container.addSubview(tableVC.view)
                        tableVC.didMove(toParent: self)
                        tableVC.courses = self.courses
                    }
                }
            }
        }
    }
    
    @IBAction func addCourseBtn(_ sender: UIButton) {
        let courseForm = CourseForm(courseID: courseIDTF.text, courseTitle: courseTitleTF.text, credits: Int(creditsTF.text!))
        api.postJsonEntity(withForm: courseForm) { (response) in
            if response.statusCode == 200 {
                let alert = UIAlertController(title: "Success", message: "Course Saved!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
}
