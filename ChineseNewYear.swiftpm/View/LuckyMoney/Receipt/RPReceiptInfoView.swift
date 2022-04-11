//
//  RPReceiptInfoView.swift
//
//  Created by roy on 2022/2/22.
//

import SwiftUI

struct RPReceiptInfoView: View {
    var model: RedPacketModel
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 60) {
                VStack(spacing: 10) {
                    Text("\(model.senderAvatar) Sent by \(model.senderName)")
                        .font(.system(size: 50, weight: .medium))
                        .foregroundColor(Color(hex: "161616"))
                    
                    Text(model.msg)
                        .font(.system(size: 25))
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .foregroundColor(Color(hex: "B5B5B5"))
                }
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("1 Red Packet with ¥ \(model.amount) in total")
                        .font(.system(size: 20))
                        .foregroundColor(Color(hex: "B5B5B5"))
                    
                    Divider()
                        .foregroundColor(Color(hex: "B5B5B5"))
                    
                    RPReceiptCellView(model: model)
                }
                .padding(.horizontal, 20)
            }
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
        }
    }
}
