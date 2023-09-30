//
//  ProfessorsRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation

protocol ProfessorsRepositing {
    func fetchProfessors() -> [Professor]
}

final class ProfessorsRepository {
    
}

extension ProfessorsRepository: ProfessorsRepositing {
    func fetchProfessors() -> [Professor] {
        return [
            .init(name: "Henrique Leitão"),
            .init(name: "Corneli"),
            .init(name: "Ione"),
            .init(name: "Levi"),
            .init(name: "Darielson")
        ]
    }
}
