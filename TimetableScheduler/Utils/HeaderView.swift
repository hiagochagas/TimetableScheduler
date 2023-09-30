//
//  HeaderView.swift
//  TimetableScheduler
//
//  Created by PremierSoft on 30/09/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                institutionName
                Spacer()
                profileImage
            }
            HStack {
                greetingText
                Spacer()
                refreshButton
                    .padding(.trailing, 8)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
        .background(Color.gray)
    }
    
    private var profileImage: some View {
        Image(systemName: "person")
          .resizable()
          .frame(width: 20, height: 20)
          .foregroundStyle(.white)
          .padding(20)
          .background(Color.green)
          .clipShape(Circle())
    }
    
    private var institutionName: some View {
        Text("Instituto Federal do Ceará")
            .foregroundStyle(.white)
    }
    
    
    private var greetingText: some View {
        Text("Greetings, administrator")
            .foregroundStyle(.white)
    }
    
    private var refreshButton: some View {
        Image(systemName: "arrow.clockwise")
            .resizable()
            .foregroundStyle(.white)
            .frame(width: 20, height: 22)
            
    }
}

#Preview {
    HeaderView()
}
