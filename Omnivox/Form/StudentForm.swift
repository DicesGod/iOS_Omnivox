//
//  StudentForm.swift
//  Omnivox
//
//  Created by english on 2019-07-18.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit

struct StudentForm: ApiJsonForm, Hashable {
    
    let studentID: String!
    let name: String!
    
    func getURL() -> String {
        return "http://localhost:8080/student/create"
    }
    
    func getJsonData() -> Data? {
        var student = [String: Any]()
        student["studentID"] = self.studentID
        student["name"] = self.name
        do {
            return try JSONSerialization.data(withJSONObject: student, options: [])
        } catch {
            print("Cannot convert \(self) to JSON Object!")
            return nil
        }
    }
}
