//
//  TabBarCoursesTVC.swift
//  Omnivox
//
//  Created by english on 2019-07-22.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit

class TabBarCoursesTVC: UITableViewController {
    
    var courses = [CourseForm]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CourseCell", bundle: nil), forCellReuseIdentifier: "CourseCell")
        
        self.refreshControl?.addTarget(self, action: #selector(refreshCourses(_:)), for: .valueChanged)
    }
    
    @objc
    func refreshCourses(_ sender: Any) {
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
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell") as? CourseCell {
            cell.courseIDLbl.text = self.courses[indexPath.row].courseID
            cell.courseTitleLbl.text = self.courses[indexPath.row].courseTitle
            cell.creditsLbl.text = String(self.courses[indexPath.row].credits)
            return cell
        } else {
            return CourseCell()
        }
    }
}
