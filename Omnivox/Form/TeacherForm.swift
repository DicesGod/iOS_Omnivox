//
//  TeacherForm.swift
//  Omnivox
//
//  Created by english on 2019-07-22.
//  Copyright © 2019 english. All rights reserved.
//

import Foundation

struct TeacherForm: ApiJsonForm, Hashable {
    
    let teacherID: String!
    let name: String!
    
    func getURL() -> String {
        return "http://localhost:8080/teacher/create"
    }
    
    func getJsonData() -> Data? {
        var teacher = [String: Any]()
        teacher["teacherID"] = self.teacherID
        teacher["name"] = self.name
        do {
            return try JSONSerialization.data(withJSONObject: teacher, options: [])
        } catch {
            print("Cannot convert \(self) to JSON Object!")
            return nil
        }
    }
}
