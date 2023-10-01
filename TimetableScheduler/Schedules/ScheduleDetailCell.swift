//
//  ScheduleDetailCell.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import SwiftUI

struct ScheduleDetailCell: View {
    private let startTime: String
    private let endTime: String
    
    init(startTime: String, endTime: String) {
        self.startTime = startTime
        self.endTime = endTime
    }
    
    var body: some View {
        ZStack {
            backgroundShadow
            VStack(spacing: 8) {
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
    
    private var timeLabel: some View {
        HStack {
            Text("\(startTime) until \(endTime)")
            Spacer()
        }
    }
}
