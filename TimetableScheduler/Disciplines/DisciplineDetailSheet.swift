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
    @State var discipline: Discipline
    var delegate: DisciplineDetailSheetDelegate?
    var isCreationType: Bool
    
    var body: some View {
        NavigationStack {
            contentView
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        discipline.name = name.isEmpty ? discipline.name : name
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
