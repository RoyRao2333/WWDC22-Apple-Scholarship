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
                    .scaleEffect(2)
                    .offset(y: -geo.size.height)
            }
            .frame(width: geo.size.width)
            .background(Color.white)
            .clipped()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct RPReceiptContentView_Previews: PreviewProvider {
    static var previews: some View {
        RPReceiptContentView(model: RedPackageModel(
            isMine: false,
            senderName: "Alex",
            senderAvatar: "👱🏻",
            msg: "Best Wishes to you, \("Roy")! Without your help, I couldn't have won the scholarship. You are my best buddy, happy New Year!",
            amount: "500",
            receiverName: "Roy",
            receiverAvatar: "🧑🏻‍💻"
        ))
        .previewDevice("iPad Pro (12.9-inch) (5th generation)")
    }
}
