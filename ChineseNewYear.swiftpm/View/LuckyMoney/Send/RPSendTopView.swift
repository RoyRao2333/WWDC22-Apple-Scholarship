//
//  RPSendTopView.swift
//
//  Created by roy on 2022/2/18.
//

import SwiftUI

struct RPSendTopView: View {
    
    var body: some View {
        HStack {
            Text("Send Red Packet")
                .font(.system(size: 20))
                .lineLimit(1)
                .foregroundColor(Color(hex: "171717"))
        }
    }
}
