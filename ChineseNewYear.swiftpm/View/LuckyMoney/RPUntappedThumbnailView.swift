//
//  RPUntappedThumbnailView.swift
//
//  Created by roy on 2022/2/22.
//

import SwiftUI

struct RPUntappedThumbnailView: View {
    @Binding var showReceive: Bool
    
    var message: String
    
    var playMode: RPPlayMode
    
    var body: some View {
        Button {
            if playMode == .receive {
                withAnimation {
                    showReceive = true
                }
            }
        } label: {
            VStack(spacing: 5) {
                HStack(spacing: 10) {
                    Image("red_packet")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    
                    Text(message)
                        .font(.system(size: 30, weight: .medium))
                        .lineLimit(1)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                
                Divider()
                    .background(Color.white)
                
                HStack {
                    Text("Red Packet")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
            }
            .padding(10)
            .background(Color(hex: "#e3a058"))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
