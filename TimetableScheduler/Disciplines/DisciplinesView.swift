//
//  DisciplinesView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI

struct DisciplinesView: View {
    @State private var isCreatingDiscipline: Bool = false
    @State private var selectedDiscipline: Discipline?
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
        HeaderView(admin: viewModel.admin, buttonType: .create, delegate: self)
            .sheet(isPresented: $isCreatingDiscipline) {
                let newDiscipline = Discipline(name: "")
                openSheet(with: newDiscipline, isCreating: true)
            }
    }
    
    private var contentView: some View {
        List {
            ForEach(viewModel.state.disciplines) { discipline in
                DisciplineDetailCell(disciplineName: discipline.name)
                .onTapGesture {
                    selectedDiscipline = discipline
                }
            }
            .listRowSeparator(.hidden)
            Color(.clear)
                .frame(height: 60)
                .listRowSeparator(.hidden)
        }
        .sheet(item: $selectedDiscipline) { discipline in
            openSheet(with: discipline, isCreating: false)
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
    }
    
    private func openSheet(with discipline: Discipline, isCreating: Bool) -> some View {
        DisciplineDetailSheet(discipline: discipline, delegate: self, isCreationType: isCreating)
            .presentationDetents([.height(150)])
    }
}

extension DisciplinesView: DisciplineDetailSheetDelegate {
    func create(discipline: Discipline) {
        viewModel.addDiscipline(discipline)
    }
    
    func delete(discipline: Discipline) {
        viewModel.deleteDiscipline(discipline)
    }
    
    func update(discipline: Discipline) {
        viewModel.updateDiscipline(discipline)
    }
}

extension DisciplinesView: HeaderViewDelegate {
    func didTapButton() {
        isCreatingDiscipline = true
    }
}
