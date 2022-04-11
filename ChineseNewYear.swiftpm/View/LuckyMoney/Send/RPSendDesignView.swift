//
//  RPSendDesignView.swift
//
//  Created by roy on 2022/2/18.
//

import SwiftUI

struct RPSendDesignView: View {
    @ObservedObject private var service: RPService = .shared
    @State private var amount = ""
    @State private var message = ""
    @Binding var showSend: Bool
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                // Amount
                HStack {
                    Text("Amount")
                        .foregroundColor(Color(hex: "161616"))
                    
                    Spacer()
                    
                    TextField("¥ 0.00", text: $amount)
                        .lineLimit(1)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Color(hex: "B5B5B5"))
                        .modifier(NumberOnlyTextField(text: $amount))
                }
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal)
                
                // Message
                HStack {
                    TextField("Say something...", text: $message)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(hex: "161616"))
                    
                    Spacer()
                }
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal)
            }
            .font(.system(size: 20))
            .lineLimit(1)
            
            GeometryReader { geo in
                VStack(alignment: .center, spacing: 20) {
                    Group {
                        Text("¥ ")
                            .font(.system(size: 30, weight: .semibold))
                        
                        +
                        
                        Text(amount.isEmpty ? "0.00" : amount)
                            .font(.system(size: 60, weight: .semibold))
                    }
                    .lineLimit(1)
                    .foregroundColor(Color(hex: "171717"))
                    
                    Button {
                        service.myRedPacketModel = .init(
                            isMine: true,
                            senderName: service.yourNickName,
                            senderAvatar: "🧑🏻‍💻",
                            msg: message,
                            amount: amount,
                            receiverName: "Lisa",
                            receiverAvatar: "👱🏻‍♀️"
                        )
                        showSend = false
                    } label: {
                        Text("Send")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 70)
                            .background(Color(hex: "DA7359"))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .position(x: geo.size.width / 2, y: geo.size.height / 2)
            }
        }
    }
}
