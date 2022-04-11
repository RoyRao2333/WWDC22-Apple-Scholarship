//
//  RPSendContentView.swift
//
//  Created by roy on 2022/2/18.
//

import SwiftUI

struct RPSendContentView: View {
    @Binding var showSend: Bool
    
    var body: some View {
        VStack(spacing: 50) {
            RPSendTopView()
            
            RPSendDesignView(showSend: $showSend)
        }
        .padding(30)
        .background(Color(hex: "EDEDED"))
    }
}
