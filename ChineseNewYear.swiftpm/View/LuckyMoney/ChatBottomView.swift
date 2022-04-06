//
//  ChatBottomView.swift
//
//  Created by roy on 2022/2/15.
//

import SwiftUI

struct ChatBottomView: View {
    @Binding var isOpened: Bool
    
    var model: RedPackageModel
    var playMode: RPPlayMode
    
    var body: some View {
        HStack {
            Spacer()
            
            switch playMode {
                case .send:
                    HStack {
                        Spacer()
                        
                        Text(
                            !isOpened
                                ? "🧧"
                                : "Red Packet is opened by \(model.receiverName) 🥳 You can tap the Red Packet above to see the details ☝🏻"
                        )
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(!isOpened ? Color(hex: "#f2f2f2") : Color(hex: "#5db269"))
                    .clipShape(Capsule())
                    .contentShape(Rectangle())
                    
                case .receive:
                    HStack {
                        Spacer()
                        
                        Text(
                            !isOpened
                                ? "Tap the Red Packet above and open it! ☝🏻"
                                : "You've opened \(model.receiverName)'s Red Packet! 🥳 \nYou can tap the Red Packet above to see the details ☝🏻"
                        )
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .foregroundColor(!isOpened ? Color(hex: "797979") : .white)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(!isOpened ? Color(hex: "#f2f2f2") : Color(hex: "#5db269"))
                    .clipShape(Capsule())
                    .contentShape(Rectangle())
                    .padding()
            }
            
            Spacer()
        }
        .padding(.top, 10)
        .padding(.horizontal, 15)
        .background(Color(hex: "#fcfcfc"))
    }
}
