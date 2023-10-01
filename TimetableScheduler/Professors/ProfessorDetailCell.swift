//
//  ProfessorDetailCell.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import SwiftUI

struct ProfessorDetailCell: View {
    private let professorName: String
    private let email: String
    private let disciplines: [Cell<Discipline>]
    
    init(professorName: String, email: String, disciplines: [Cell<Discipline>]) {
        self.professorName = professorName
        self.email = email
        self.disciplines = disciplines
    }
    
    var body: some View {
        ZStack {
            backgroundShadow
            VStack(spacing: 8) {
                nameLabel
                emailLabel
                disciplinesLabel
            }
            .padding(.all, 16)
        }
    }
    
    private var backgroundShadow: some View {
        RoundedRectangle(cornerRadius: 8.0)
            .fill(Color.white)
            .frame(height: 120)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
    
    private var nameLabel: some View {
        HStack {
            Text(professorName)
            Spacer()
        }
    }
    
    private var emailLabel: some View {
        HStack {
            Text("Email: \(email)")
            Spacer()
        }
    }
    
    private var disciplinesLabel: some View {
        VStack {
            if !disciplines.isEmpty {
                HStack {
                    Text("Disciplines:")
                    Spacer()
                }
                ForEach(disciplines) { discipline in
                    HStack {
                        Text(discipline.object.name)
                        Spacer()
                    }
                }
            }
        }
    }
}
