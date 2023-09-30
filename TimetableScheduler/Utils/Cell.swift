//
//  Cell.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 29/09/23.
//

import Foundation

public struct Cell<T: Equatable>: Identifiable, Equatable {
    
    public var id: UUID
    public var object: T
    
    public init(id: UUID = UUID(), object: T) {
        self.id = id
        self.object = object
    }
}
