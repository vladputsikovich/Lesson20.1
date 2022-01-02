//
//  Student.swift
//  Lesson20.1
//
//  Created by Владислав Пуцыкович on 2.01.22.
//

import Foundation

class Student {
    var name: String
    var female: String
    var grade: Double
    
    init(_ name: String, _ female: String, _ grade: Double) {
        self.name = name
        self.female = female
        self.grade = grade
    }
}
