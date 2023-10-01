//
//  Room.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 29/09/23.
//

import Foundation

struct Room: Equatable {
    let name: String
    let capacity: Int
    let disciplines: [Discipline]
}
