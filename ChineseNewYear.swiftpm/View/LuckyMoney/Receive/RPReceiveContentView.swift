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
                    .frame(width: geo.size.width, height: geo.size.height / 4 * 3)
                
                Color(hex: "DE604C")
                    .offset(y: isOpened ? geo.size.height * 2 : 0)
                    .clipped()
                
                Color(hex: "#ac322a")
                    .clipShape(Circle())
                    .frame(width: geo.size.height, height: geo.size.height)
                    .offset(y: -geo.size.height / 4)
                    .offset(y: isOpened ? -geo.size.height / 2 : 0)
                    .clipped()
                
                RPReceiveOpenButton(rotation: $rotation)
                    .offset(y: -geo.size.height / 4 + 40)
                    .isHidden(hideBtn)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color.white)
            .clipped()
        }
        .background(Color.gray)
        .aspectRatio(0.69, contentMode: .fit)
        .edgesIgnoringSafeArea(.all)
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
