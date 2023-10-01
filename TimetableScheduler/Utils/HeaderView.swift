//
//  HeaderView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import SwiftUI

protocol HeaderViewDelegate {
    func didTapButton()
}

struct HeaderView: View {
    enum ButtonType {
        case refresh
        case create
        
        var imageName: String {
            switch self {
            case .refresh:
                "arrow.clockwise"
            case .create:
                "pencil"
            }
        }
    }
    
    private let buttonType: ButtonType
    private var delegate: HeaderViewDelegate?
    
    init(buttonType: ButtonType = .refresh, delegate: HeaderViewDelegate? = nil) {
        self.buttonType = buttonType
        self.delegate = delegate
    }
    
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
                if buttonType != .refresh {
                    actionButton
                        .padding(.trailing, 8)
                }
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
    
    private var actionButton: some View {
        Button {
            delegate?.didTapButton()
        } label: {
            Image(systemName: buttonType.imageName)
                .resizable()
                .foregroundStyle(.white)
                .frame(width: 20, height: 22)
        }      
    }
}

#Preview {
    HeaderView()
}
