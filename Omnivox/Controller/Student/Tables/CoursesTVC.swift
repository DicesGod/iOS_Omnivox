//
//  CoursesTVC.swift
//  Omnivox
//
//  Created by english on 2019-07-22.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit

class CoursesTVC: UITableViewController {
    
    var courses = [CourseForm]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CourseCell", bundle: nil), forCellReuseIdentifier: "CourseCell")
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
