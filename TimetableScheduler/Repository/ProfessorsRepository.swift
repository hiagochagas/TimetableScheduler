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
            .init(name: "Henrique Leitão", email: "", disciplines: []),
            .init(name: "Corneli", email: "", disciplines: []),
            .init(name: "Ione", email: "", disciplines: []),
            .init(name: "Levi", email: "", disciplines: []),
            .init(name: "Darielson", email: "", disciplines: [])
        ]
    }
}
