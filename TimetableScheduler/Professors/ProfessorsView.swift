//
//  ProfessorsView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI

struct ProfessorsView: View {
    @State private var isCreatingProfessor: Bool = false
    @State private var selectedProfessor: Professor?
    @ObservedObject private var viewModel: ProfessorsViewModel
    
    init(viewModel: ProfessorsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            topContent
            contentView
        }
    }
    
    private var topContent: some View {
        HeaderView(admin: viewModel.admin, buttonType: .create, delegate: self)
            .sheet(isPresented: $isCreatingProfessor) {
                let newProfessor = Professor(
                    name: "",
                    email: "",
                    disciplines: []
                )
                openSheet(with: newProfessor, isCreating: true)
            }
    }
    
    private var contentView: some View {
        List {
            ForEach(viewModel.state.professors) { professor in
                ProfessorDetailCell(
                    professorName: professor.name,
                    email: professor.email,
                    disciplines: professor.disciplines
                )
                .onTapGesture {
                    selectedProfessor = professor
                }
            }
            .listRowSeparator(.hidden)
            Color(.clear)
                .frame(height: 60)
                .listRowSeparator(.hidden)
        }
        .sheet(item: $selectedProfessor) { professor in
            openSheet(with: professor, isCreating: false)
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
    }
    
    private func openSheet(with professor: Professor, isCreating: Bool) -> some View {
        ProfessorDetailSheet(
            professor: professor,
            delegate: self,
            isCreationType: isCreating,
            disciplines: viewModel.getDisciplines(),
            schedules: viewModel.getSchedules()
        )
        .presentationDetents([.height(200)])
    }
}

extension ProfessorsView: ProfessorDetailSheetDelegate {
    func update(professor: Professor) {
        viewModel.addProfessor(professor)
    }
    
    func delete(professor: Professor) {
        viewModel.deleteProfessor(professor)
    }
    
    func create(professor: Professor) {
        viewModel.addProfessor(professor)
    }
}

extension ProfessorsView: HeaderViewDelegate {
    func didTapButton() {
        isCreatingProfessor = true
    }
}
