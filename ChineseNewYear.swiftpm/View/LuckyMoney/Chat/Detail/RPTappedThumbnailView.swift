//
//  RPTappedThumbnailView.swift
//
//  Created by roy on 2022/2/22.
//

import SwiftUI

struct RPTappedThumbnailView: View {
    var model: RedPacketModel
    
    var body: some View {
        NavigationLink {
            RPReceiptContentView(model: model)
        } label: {
            VStack(spacing: 5) {
                HStack(spacing: 10) {
                    Image("red_packet")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    
                    VStack(alignment: .leading) {
                        Text("Best Wishes!")
                            .font(.system(size: 30, weight: .medium))
                            .lineLimit(1)
                        
                        Text("Opened")
                            .font(.system(size: 18))
                    }
                    
                    Spacer()
                }
                
                Divider()
                    .background(Color.secondary)
                
                HStack {
                    Text("Red Packet")
                        .font(.system(size: 18))
                    
                    Spacer()
                }
            }
            .foregroundColor(.white)
            .padding(10)
            .background(Color(hex: "#dbc0aa"))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
