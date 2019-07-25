//
//  CourseForm.swift
//  Omnivox
//
//  Created by english on 2019-07-22.
//  Copyright © 2019 english. All rights reserved.
//

import Foundation

struct CourseForm: ApiJsonForm, Hashable {
    
    let courseID: String!
    let courseTitle: String!
    let credits: Int!
    
    func getURL() -> String {
        return "http://localhost:8080/course/create"
    }
    
    func getJsonData() -> Data? {
        var course = [String: Any]()
        course["courseID"] = self.courseID
        course["courseTitle"] = self.courseTitle
        course["credits"] = self.credits
        do {
            return try JSONSerialization.data(withJSONObject: course, options: [])
        } catch {
            print("Cannot convert \(self) to JSON Object!")
            return nil
        }
    }
}
