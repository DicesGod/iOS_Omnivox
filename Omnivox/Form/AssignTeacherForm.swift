//
//  AssignTeacherForm.swift
//  Omnivox
//
//  Created by english on 2019-07-25.
//  Copyright © 2019 english. All rights reserved.
//

import Foundation

struct AssignTeacherForm: ApiJsonForm, Hashable {
    
    let teacherID: String!
    let courseID: String!
    
    func getURL() -> String {
        return "http://localhost:8080/assign/teacher"
    }
    
    func getJsonData() -> Data? {
        var assign = [String: Any]()
        assign["teacherID"] = self.teacherID
        assign["courseID"] = self.courseID
        do {
            return try JSONSerialization.data(withJSONObject: assign, options: [])
        } catch {
            print("Cannot convert \(self) to JSON Object!")
            return nil
        }
    }
}
