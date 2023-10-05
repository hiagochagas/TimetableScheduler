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
    @Relationship
    var professors: [Professor] = []
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
}
