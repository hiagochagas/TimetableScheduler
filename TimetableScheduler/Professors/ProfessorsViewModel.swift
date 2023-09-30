//
//  ProfessorsViewModel.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation

protocol ProfessorsViewModeling {
    func getAllProfessors() -> [Cell<Professor>]
}

final class ProfessorsViewModel {
    private var state: ProfessorsState = .init()
    private let professorsRepository: ProfessorsRepositing
    
    init(professorsRepository: ProfessorsRepositing) {
        self.professorsRepository = professorsRepository
        state.professors = fetchProfessors()
    }
}

extension ProfessorsViewModel {
    private func fetchProfessors() -> [Cell<Professor>] {
        return professorsRepository.fetchProfessors().compactMap { professor in
            Cell(object: professor)
        }
    }
}

extension ProfessorsViewModel: ProfessorsViewModeling {
    func getAllProfessors() -> [Cell<Professor>]{
        return state.professors
    }
}
