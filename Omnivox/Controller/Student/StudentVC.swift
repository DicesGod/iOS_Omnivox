//
//  StudentVC.swift
//  Omnivox
//
//  Created by english on 2019-07-18.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit

class StudentVC: UIViewController {
    
    @IBOutlet weak var studentIDTF: UITextField!
    
    @IBOutlet weak var container: UIView!
    
    var courses = [CourseForm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func refreshTable() {
        api.getJsonEntities(withURL: "http://localhost:8080/student/\(studentIDTF.text!)/courses") { (response, json) in
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
                    if let tableVC = self.storyboard?.instantiateViewController(withIdentifier: "StudentCoursesTable") as? CoursesTVC {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AvailableCoursesSegue" {
            if let vc = segue.destination as? AvailableCoursesTVC {
                vc.activeStudentID = studentIDTF.text!
                studentIDTF.text = ""
            }
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "AvailableCoursesSegue" {
            if studentIDTF.text! == "" {
                let alert = UIAlertController(title: "Warning", message: "Please enter your Student ID first!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }

    @IBAction func myCoursesBtn(_ sender: UIButton) {
        refreshTable()
    }
}
