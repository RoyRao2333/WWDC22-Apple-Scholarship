//
//  RPReceiptContentView.swift
//
//  Created by roy on 2022/2/22.
//

import SwiftUI

struct RPReceiptContentView: View {
    var model: RedPackageModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                RPReceiptInfoView(model: model)
                    .frame(width: geo.size.width, height: geo.size.height / 4 * 3)
                
                Color(hex: "#ac322a")
                    .clipShape(Circle())
                    .frame(width: geo.size.height, height: geo.size.height)
                    .offset(y: -geo.size.height / 2)
            }
            .frame(width: geo.size.width)
            .background(Color.white)
            .clipped()
        }
        .aspectRatio(0.46, contentMode: .fill)
        .edgesIgnoringSafeArea(.all)
    }
}
