//
//  AssignStudentForm.swift
//  Omnivox
//
//  Created by english on 2019-07-25.
//  Copyright © 2019 english. All rights reserved.
//

import Foundation

struct AssignStudentForm: ApiJsonForm, Hashable {
    
    let studentID: String!
    let courseID: String!
    
    func getURL() -> String {
        return "http://localhost:8080/assign/student"
    }
    
    func getJsonData() -> Data? {
        var assign = [String: Any]()
        assign["studentID"] = self.studentID
        assign["courseID"] = self.courseID
        do {
            return try JSONSerialization.data(withJSONObject: assign, options: [])
        } catch {
            print("Cannot convert \(self) to JSON Object!")
            return nil
        }
    }
}
