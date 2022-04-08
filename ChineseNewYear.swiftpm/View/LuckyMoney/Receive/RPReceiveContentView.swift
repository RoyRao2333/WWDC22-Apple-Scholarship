//
//  RPReceiveContentView.swift
//
//  Created by roy on 2022/2/18.
//

import SwiftUI

public struct RPReceiveContentView: View {
    @Binding var showReceive: Bool
    @Binding var isOpened: Bool
    @State private var rotation: Double = 0
    @State private var hideBtn = false
    @State private var redPacketSize: CGSize = .zero
    
    public var model: RedPackageModel
    
    public init(
        model: RedPackageModel,
        showReceive: Binding<Bool>,
        isOpened: Binding<Bool>
    ) {
        self._showReceive = showReceive
        self._isOpened = isOpened
        self.model = model
    }
    
    public var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                RPReceiveInfoView(showReceive: $showReceive, model: model)
                    .background(Color.white)
                    .measureSize { size in
                        redPacketSize = size
                    }
                
                Color(hex: "DE604C")
                    .offset(y: isOpened ? geo.size.height * 2 : 0)
                    .clipped()
                
                Color(hex: "#ac322a")
                    .clipShape(Circle())
                    .scaleEffect(2)
                    .offset(y: -redPacketSize.height / 2)
                    .offset(y: isOpened ? -geo.size.height / 4 : 0)
                    .clipped()
                
                RPReceiveOpenButton(rotation: $rotation)
                    .offset(y: -redPacketSize.height / 4 - 20 )
                    .isHidden(hideBtn)
            }
            .frame(width: 670, height: 970)
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
        }
        .edgesIgnoringSafeArea(.vertical)
        .background(Color.black.opacity(0.5))
        .onChange(of: rotation) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    hideBtn = true
                }
                
                withAnimation(.linear(duration: 0.5).delay(0.1)) {
                    isOpened = true
                }
            }
        }
    }
}

struct RPReceiveContentView_Previews: PreviewProvider {
    static var previews: some View {
        RPReceiveContentView(model: RedPackageModel(
            isMine: false,
            senderName: "Alex",
            senderAvatar: "👱🏻",
            msg: "Best Wishes to you, \("Roy")! Without your help, I couldn't have won the scholarship. You are my best buddy, happy New Year!",
            amount: "500",
            receiverName: "Roy",
            receiverAvatar: "🧑🏻‍💻"
        ), showReceive: .constant(true), isOpened: .constant(false))
        .previewDevice("iPad Pro (12.9-inch) (5th generation)")
    }
}
