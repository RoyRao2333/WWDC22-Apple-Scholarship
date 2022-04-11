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
    
    public var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ChatTopView(avatar: "👱🏻‍♀️", name: "Lisa")
                
                GeometryReader { _ in
                    ChatListView(
                        isOpened: $isOpened,
                        showSend: $showSend,
                        showReceive: .constant(false),
                        playMode: .send
                    )
                }
                
                ChatBottomView(isOpened: $isOpened, playMode: .send)
            }
            
            if showSend {
                RPSendContentView(showSend: $showSend)
            }
        }
//        .navigationBarHidden(true)
    }
}
