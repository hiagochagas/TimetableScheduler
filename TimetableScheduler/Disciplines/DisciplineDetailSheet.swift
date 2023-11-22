//
//  DisciplineDetailSheet.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 01/10/23.
//

import SwiftUI

protocol DisciplineDetailSheetDelegate {
    func create(discipline: Discipline)
    func delete(discipline: Discipline)
    func update(discipline: Discipline)
}

struct DisciplineDetailSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var semester: Int
    @State var discipline: Discipline
    var delegate: DisciplineDetailSheetDelegate?
    var isCreationType: Bool
    
    init(discipline: Discipline, delegate: DisciplineDetailSheetDelegate? = nil, isCreationType: Bool) {
        self._discipline = State(initialValue: discipline)
        self.delegate = delegate
        self.isCreationType = isCreationType
        self._semester = State(initialValue: discipline.semester)
    }
    
    var body: some View {
        NavigationStack {
            contentView
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        discipline.name = name.isEmpty ? discipline.name : name
                        discipline.semester = semester
                        if isCreationType {
                            delegate?.create(discipline: discipline)
                        } else {
                            delegate?.update(discipline: discipline)
                        }
                        dismiss()
                    }.tint(.green)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }.tint(.green)
                }
            }
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 16) {
            nameLabel
            semesterSelector
            if !isCreationType {
                deleteButton
            }
        }
        .padding(.all, 20)
    }
    
    private var nameLabel: some View {
        HStack {
            Text("Name: ")
            Spacer()
            TextField("\(discipline.name)", text: $name)
        }
    }
    
    private var semesterSelector: some View {
        HStack {
            Text("Semester: ")
            Spacer()
            Picker("Semester", selection: $semester) {
                ForEach(1...8, id: \.self) {
                    Text("\($0)")
                }
            }.tint(.green)
        }
    }
    
    private var deleteButton: some View {
        Button(action: {
            delegate?.delete(discipline: discipline)
            dismiss()
        }, label: {
            Text("Delete discipline")
                .foregroundStyle(.red)
        })
    }
}
