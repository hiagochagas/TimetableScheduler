//
//  DisciplineDetailCell.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import SwiftUI

struct DisciplineDetailCell: View {
    private let disciplineName: String
    private let semester: Int
    
    init(disciplineName: String, semester: Int) {
        self.disciplineName = disciplineName
        self.semester = semester
    }
    
    var body: some View {
        ZStack {
            backgroundShadow
            VStack(spacing: 8) {
                disciplineLabel
                semesterLabel
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
    
    private var semesterLabel: some View {
        HStack {
            Text("Semester \(semester)")
            Spacer()
        }
    }
}
