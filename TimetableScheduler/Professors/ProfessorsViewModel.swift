//
//  ProfessorsViewModel.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation

final class ProfessorsViewModel: ObservableObject {
    @Published var state: ProfessorsState = .init()
    private let professorsRepository: ProfessorsRepositing
    let admin: Admin
    
    init(professorsRepository: ProfessorsRepositing, admin: Admin) {
        self.professorsRepository = professorsRepository
        self.admin = admin
        fetchProfessors()
    }
}

extension ProfessorsViewModel {
    private func fetchProfessors() {
        state.professors = professorsRepository.fetchProfessors()
    }
}

extension ProfessorsViewModel {
    func updateProfessor(_ professor: Professor) {
        professorsRepository.updateProfessor(professor)
        fetchProfessors()
    }
    
    func addProfessor(_ professor: Professor) {
        professorsRepository.addProfessor(professor)
        fetchProfessors()
    }
    
    private func createProfessor(_ professor: Professor) {
        professorsRepository.addProfessor(professor)
        fetchProfessors()
    }
    
    func deleteProfessor(_ professor: Professor) {
        professorsRepository.deleteProfessor(professor)
        fetchProfessors()
    }
}
