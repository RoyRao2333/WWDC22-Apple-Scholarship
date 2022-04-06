//
//  ChatTopView.swift
//
//  Created by roy on 2022/2/15.
//

import SwiftUI

struct ChatTopView: View {
    var avatar: String
    var name: String
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack(spacing: 5) {
                Text(avatar)
                    .font(.system(size: 50))
                    .padding(8)
                    .background(Color(hex: "76C6D4"))
                    .clipShape(Circle())
                
                Text(name)
                    .font(.system(size: 20))
            }
            .padding(.top)
            
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.bottom, 10)
        .padding(.horizontal, 10)
        .background(Color(hex: "#4284F6"))
    }
}
