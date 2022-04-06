//
//  RPSendDesignView.swift
//
//  Created by roy on 2022/2/18.
//

import SwiftUI

struct RPSendDesignView: View {
    @Binding var showSend: Bool
    
    var model: RedPackageModel
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                // Amount
                HStack {
                    Text("Amount")
                        .foregroundColor(Color(hex: "161616"))
                    
                    Spacer()
                    
                    Text("¥ \(model.amount.isEmpty ? "0.00" : model.amount)")
                        .lineLimit(1)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Color(hex: "B5B5B5"))
                }
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal)
                
                // Message
                HStack {
                    Text(model.msg)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(hex: "B5B5B5"))
                    
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
                    Text("¥ ")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(Color(hex: "171717"))
                    
                    +
                    
                    Text(model.amount.isEmpty ? "0.00" : model.amount)
                        .font(.system(size: 60, weight: .semibold))
                        .foregroundColor(Color(hex: "171717"))
                    
                    Button {
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
