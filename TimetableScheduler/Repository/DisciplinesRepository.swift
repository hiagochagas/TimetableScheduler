//
//  DisciplinesRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation

protocol DisciplinesRepositing {
    func fetchDisciplines() -> [Discipline]
}

final class DisciplinesRepository {
    
}

extension DisciplinesRepository: DisciplinesRepositing {
    func fetchDisciplines() -> [Discipline] {
        [
            .init(name: "APS"),
            .init(name: "TJW"),
            .init(name: "Administração"),
            .init(name: "Compiladores"),
            .init(name: "RNA")
        ]
    }
}
