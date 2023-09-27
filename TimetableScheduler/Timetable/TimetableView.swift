//
//  TimetableView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI

struct TimetableView: View {
    var body: some View {
        VStack {
            topContent
            timetableView
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Views
extension TimetableView {
    private var topContent: some View {
        VStack(spacing: 24) {
            HStack {
                institutionName
                Spacer()
                circleImage
            }
            HStack {
                greetingText
                Spacer()
                refreshButton
                    .padding(.trailing, 8)
            }
        }
    }
    
    private var circleImage: some View {
        Image(systemName: "person")
          .resizable()
          .frame(width: 20, height: 20)
          .foregroundColor(.white)
          .padding(20)
          .background(Color.green)
          .clipShape(Circle())
    }
    
    private var institutionName: some View {
        Text("Instituto Federal do Ceará")
    }
    
    
    private var greetingText: some View {
        Text("Greetings, administrator")
    }
    
    private var refreshButton: some View {
        Image(systemName: "arrow.clockwise")
            .resizable()
            .frame(width: 20, height: 22)
            
    }
    
    private var timetableView: some View {
        List {
            ForEach(Weekdays.allCases, id: \.rawValue) { weekday in
                Section {
                    Text(weekday.sectionName)
                }
            }
        }
    }
}

struct TimetableView_Previews: PreviewProvider {
    static var previews: some View {
        TimetableView()
    }
}
