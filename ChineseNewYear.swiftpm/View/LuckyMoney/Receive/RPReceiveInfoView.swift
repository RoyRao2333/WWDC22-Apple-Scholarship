//
//  RPReceiveInfoView.swift
//
//  Created by Roy Rao on 2022/2/19.
//

import SwiftUI

struct RPReceiveInfoView: View {
    @ObservedObject private var service: RPService = .shared
    @Binding var showReceive: Bool
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 30) {
                Spacer()
                    .frame(height: geo.size.height / 2)
                
                VStack(spacing: 5) {
                    Text("\(service.alexRedPacketModel.senderAvatar) \(service.alexRedPacketModel.senderName)'s Red Packet")
                        .font(.system(size: 30, weight: .medium))
                        .lineLimit(1)
                        .foregroundColor(Color(hex: "161616"))
                    
                    Text(service.alexRedPacketModel.msg)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .foregroundColor(Color(hex: "B5B5B5"))
                }
                .padding(.horizontal, 20)
                
                VStack(spacing: 10) {
                    Text(service.alexRedPacketModel.amount)
                        .font(.system(size: 60, weight: .semibold))
                    
                    +
                    
                    Text(" CNY")
                        .font(.system(size: 20))
                    
                    HStack(spacing: 5) {
                        Text("Red Packet transferred to Wallet")
                        
                        Image(systemName: "checkmark")
                    }
                    .font(.system(size: 20))
                    .lineLimit(1)
                }
                .foregroundColor(Color(hex: "C7AD7B"))
                .padding(.horizontal, 20)
                
                Button {
                    showReceive = false
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(hex: "B5B5B5"))
                }
                .padding(.top)
            }
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
        }
    }
}
