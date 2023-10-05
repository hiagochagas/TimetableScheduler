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
    @State var professor: Professor
    var delegate: ProfessorDetailSheetDelegate?
    var isCreationType: Bool
    
    var body: some View {
        NavigationStack {
            contentView
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        professor.name = name.isEmpty ? professor.name : name
                        professor.email = email.isEmpty ? professor.email : email
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
