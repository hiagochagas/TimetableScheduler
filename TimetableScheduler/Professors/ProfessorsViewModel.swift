//
//  ProfessorsViewModel.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation

final class ProfessorsViewModel: ObservableObject {
    @Published var state: ProfessorsState = .init()
    private let professorsRepository: any ProfessorsRepositing
    private let disciplinesRepository: any DisciplinesRepositing
    private let schedulesRepository: any SchedulesRepositing
    let admin: Admin
    
    init(
        professorsRepository: any ProfessorsRepositing,
        disciplinesRepository: any DisciplinesRepositing,
        schedulesRepository: any SchedulesRepositing,
        admin: Admin
    ) {
        self.professorsRepository = professorsRepository
        self.disciplinesRepository = disciplinesRepository
        self.schedulesRepository = schedulesRepository
        self.admin = admin
        fetchProfessors()
    }
}

extension ProfessorsViewModel {
    private func fetchProfessors() {
        state.professors = professorsRepository.getAll()
    }
    
    func getDisciplines() -> [Discipline] {
        return disciplinesRepository.getAll()
    }
    
    func getSchedules() -> [Schedule] {
        return schedulesRepository.getAll()
    }
}

extension ProfessorsViewModel {
    func updateProfessor(_ professor: Professor) {
        professorsRepository.updateModel(model: professor)
        fetchProfessors()
    }
    
    func addProfessor(_ professor: Professor) {
        professorsRepository.addModel(model: professor)
        fetchProfessors()
    }
    
    func deleteProfessor(_ professor: Professor) {
        professorsRepository.removeModel(model: professor)
        fetchProfessors()
    }
}
