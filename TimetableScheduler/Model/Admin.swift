//
//  Admin.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 04/10/23.
//

import Foundation
import SwiftData

@Model
class Admin {
    @Attribute(.unique) let email: String
    let name: String
    let password: String
    @Relationship(deleteRule: .nullify)
    var professors: [Professor] = []
    @Relationship(deleteRule: .nullify)
    var schedules: [Schedule] = []
    @Relationship(deleteRule: .nullify)
    var disciplines: [Discipline] = []
    @Relationship(deleteRule: .nullify)
    var timetables: [Timetable] = []
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
}
