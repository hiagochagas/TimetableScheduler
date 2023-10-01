//
//  DisciplinesView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI

struct DisciplinesView: View {
    @State private var isCreatingDiscipline: Bool = false
    @State private var selectedDiscipline: Cell<Discipline>?
    @ObservedObject private var viewModel: DisciplinesViewModel
    
    init(viewModel: DisciplinesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            topContent
            contentView
        }
    }
    
    private var topContent: some View {
        HeaderView(buttonType: .create, delegate: self)
            .sheet(isPresented: $isCreatingDiscipline) {
                let newProfessor = Cell(
                    object: Discipline(
                        name: "",
                        schedules: []
                    )
                )
                openSheet(with: newProfessor, isCreating: true)
            }
    }
    
    private var contentView: some View {
        List {
            ForEach(viewModel.state.disciplines) { cell in
                let discipline = cell.object
                DisciplineDetailCell(disciplineName: discipline.name)
                .onTapGesture {
                    selectedDiscipline = cell
                }
            }
            .sheet(item: $selectedDiscipline) { discipline in
                openSheet(with: discipline, isCreating: false)
            }
            .listRowSeparator(.hidden)
            Color(.clear)
                .frame(height: 60)
                .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
    }
    
    private func openSheet(with discipline: Cell<Discipline>, isCreating: Bool) -> some View {
        DisciplineDetailSheet(discipline: discipline, delegate: self, isCreationType: isCreating)
            .presentationDetents([.height(150)])
    }
}

extension DisciplinesView: DisciplineDetailSheetDelegate {
    func didSave(discipline: Cell<Discipline>) {
        viewModel.saveDiscipline(discipline)
    }
    
    func delete(discipline: Cell<Discipline>) {
        viewModel.deleteDiscipline(discipline)
    }
}

extension DisciplinesView: HeaderViewDelegate {
    func didTapButton() {
        isCreatingDiscipline = true
    }
}
