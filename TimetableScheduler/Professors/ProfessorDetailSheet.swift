//
//  ProfessorDetailSheet.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 01/10/23.
//

import SwiftUI

protocol ProfessorDetailSheetDelegate {
    func didSave(professor: Cell<Professor>)
    func delete(professor: Cell<Professor>)
}

struct ProfessorDetailSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var email: String = ""
    @State var professor: Cell<Professor>
    var delegate: ProfessorDetailSheetDelegate?
    var isCreationType: Bool
    
    var body: some View {
        NavigationStack {
            contentView
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        let newProfessor = Cell(
                            id: professor.id,
                            object: Professor(
                                name: name.isEmpty ? professor.object.name : name,
                                email: email.isEmpty ? professor.object.email : email,
                                disciplines: professor.object.disciplines
                            )
                        )
                        delegate?.didSave(professor: newProfessor)
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
            TextField("\(professor.object.name)", text: $name)
        }
    }
    
    private var emailLabel: some View {
        HStack {
            Text("Email: ")
            Spacer()
            TextField("\(professor.object.email)", text: $email)
        }
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
