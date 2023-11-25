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
    private let disciplinesRepository: DisciplinesRepositing
    private let schedulesRepository: SchedulesRepositing
    let admin: Admin
    
    init(
        professorsRepository: ProfessorsRepositing,
        disciplinesRepository: DisciplinesRepositing,
        schedulesRepository: SchedulesRepositing,
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
        state.professors = professorsRepository.fetchProfessors()
    }
    
    func getDisciplines() -> [Discipline] {
        return disciplinesRepository.fetchDisciplines()
    }
    
    func getSchedules() -> [Schedule] {
        return schedulesRepository.fetchSchedules()
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
    
    func deleteProfessor(_ professor: Professor) {
        professorsRepository.deleteProfessor(professor)
        fetchProfessors()
    }
}
