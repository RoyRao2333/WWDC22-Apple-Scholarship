//
//  RPReceiveOpenButton.swift
//
//  Created by roy on 2022/2/18.
//

import SwiftUI
import Combine

struct RPReceiveOpenButton: View {
    @Binding var rotation: Double
    
    var body: some View {
        Button {
            if rotation == 0 {
                withAnimation(.linear(duration: 0.7).repeatForever(autoreverses: false)) {
                    rotation += 360
                }
            }
        } label: {
            Text("Open")
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .semibold))
                .frame(width: 80, height: 80)
                .background(Color(hex: "E5CEA0"))
                .clipShape(Circle())
                .rotation3DEffect(
                    .degrees(rotation),
                    axis: (x: 0, y: 1, z: 0)
                )
        }
    }
}
