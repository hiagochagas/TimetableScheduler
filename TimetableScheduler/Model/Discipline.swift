//
//  Discipline.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 29/09/23.
//

import Foundation
import SwiftData

@Model
class Discipline: Equatable {
    @Attribute(.unique)
    var name: String
    var semester: Int
    
    @Relationship(inverse: \Admin.disciplines)
    var admin: Admin?
    
    init(name: String, semester: Int, admin: Admin? = nil) {
        self.name = name
        self.semester = semester
        self.admin = admin
    }
}
