//
//  ProfessorDetailCell.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import SwiftUI

struct ProfessorDetailCell: View {
    private let professorName: String
    
    init(professorName: String) {
        self.professorName = professorName
    }
    
    var body: some View {
        ZStack {
            backgroundShadow
            VStack(spacing: 8) {
                nameLabel
            }
            .padding(.all, 16)
        }
    }
    
    private var backgroundShadow: some View {
        RoundedRectangle(cornerRadius: 8.0)
            .fill(Color.white)
            .frame(width: .infinity, height: 120)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
    
    private var nameLabel: some View {
        HStack {
            Text(professorName)
            Spacer()
        }
    }
}
