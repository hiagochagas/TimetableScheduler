//
//  ProfessorDetailSheet.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 01/10/23.
//

import SwiftUI

protocol ProfessorDetailSheetDelegate {
    func create(professor: Professor)
    func delete(professor: Professor)
    func update(professor: Professor)
}

struct ProfessorDetailSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var disciplinesSelection: Set<Discipline>
    @State private var schedulesSelection: Set<Schedule>
    @State private var professor: Professor
    private let disciplines: [Discipline]
    private let schedules: [Schedule]
    var delegate: ProfessorDetailSheetDelegate?
    var isCreationType: Bool
    
    init(professor: Professor, delegate: ProfessorDetailSheetDelegate? = nil, isCreationType: Bool, disciplines: [Discipline], schedules: [Schedule]) {
        self._professor = State(initialValue: professor)
        self.delegate = delegate
        self.isCreationType = isCreationType
        self.disciplines = disciplines
        self.schedules = schedules
        self._schedulesSelection = State(initialValue: Set(professor.preferredSchedules))
        self._disciplinesSelection = State(initialValue: Set(professor.disciplines))
    }
    
    
    var body: some View {
        NavigationStack {
            contentView
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        professor.name = name.isEmpty ? professor.name : name
                        professor.email = email.isEmpty ? professor.email : email
                        professor.disciplines = Array(disciplinesSelection)
                        professor.preferredSchedules = Array(schedulesSelection)
                        if isCreationType {
                            delegate?.create(professor: professor)
                        } else {
                            delegate?.update(professor: professor)
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
            emailLabel
            disciplinesPicker
            schedulesPicker
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
            TextField("\(professor.name)", text: $name)
        }
    }
    
    private var emailLabel: some View {
        HStack {
            Text("Email: ")
            Spacer()
            TextField("\(professor.email)", text: $email)
        }
    }
    
    private var disciplinesPicker: some View {
        MultiSelector(
            label: Text("Disciplines"),
            options: disciplines,
            optionToString: { "\($0.name), semester \($0.semester)" },
            selected: $disciplinesSelection
        )
    }
    
    private var schedulesPicker: some View {
        MultiSelector(
            label: Text("Preferred schedules"),
            options: schedules,
            optionToString: { "\($0.dayOfTheWeek.sectionName) \($0.startTime) \($0.endTime)" },
            selected: $schedulesSelection
        )
    }
    
    private var deleteButton: some View {
        Button(action: {
            delegate?.delete(professor: professor)
            dismiss()
        }, label: {
            Text("Delete professor")
                .foregroundStyle(.red)
        })
    }
}
