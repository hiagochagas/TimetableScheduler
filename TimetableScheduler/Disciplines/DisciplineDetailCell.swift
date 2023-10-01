//
//  DisciplineDetailCell.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import SwiftUI

struct DisciplineDetailCell: View {
    private let disciplineName: String
    
    init(disciplineName: String) {
        self.disciplineName = disciplineName
    }
    
    var body: some View {
        ZStack {
            backgroundShadow
            VStack(spacing: 8) {
                disciplineLabel
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
    
    private var disciplineLabel: some View {
        HStack {
            Text(disciplineName)
            Spacer()
        }
    }
}
