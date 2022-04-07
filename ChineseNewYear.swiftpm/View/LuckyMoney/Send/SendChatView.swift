//
//  SendChatView.swift
//  PlaygroundBook
//
//  Created by roy on 2022/2/23.
//

import SwiftUI

public struct SendChatView: View {
    @ObservedObject private var service: RPService = .shared
    @State private var isOpened: Bool = false
    @State private var showSend: Bool = true
    
    private var model: RedPackageModel
    
    public init(model: RedPackageModel) {
        self.model = model
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    ChatTopView(avatar: "👱🏻‍♀️", name: "Lisa")
                    
                    GeometryReader { _ in
                        ChatListView(
                            isOpened: $isOpened,
                            showSend: $showSend,
                            showReceive: .constant(false),
                            model: model,
                            playMode: .send
                        )
                    }
                    
                    ChatBottomView(isOpened: $isOpened, model: model, playMode: .send)
                }
                
                if showSend {
                    RPSendContentView(showSend: $showSend, model: model)
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
        .accentColor(.white)
    }
}
