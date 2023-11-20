//
//  TimetableDetailCell.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 29/09/23.
//

import SwiftUI

struct TimetableDetailCell: View {
    private let disciplineName: String
    private let startTime: String
    private let endTime: String
    
    init(
        disciplineName: String,
        startTime: String,
        endTime: String
    ) {
        self.disciplineName = disciplineName
        self.startTime = startTime
        self.endTime = endTime
    }
    
    var body: some View {
        ZStack {
            backgroundShadow
            VStack(spacing: 8) {
                disciplineLabel
                timeLabel
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
    
    private var timeLabel: some View {
        HStack {
            Text("\(startTime) until \(endTime)")
            Spacer()
        }
    }
}
