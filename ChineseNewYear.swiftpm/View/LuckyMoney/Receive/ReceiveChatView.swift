//
//  ReceiveChatView.swift
//
//  Created by roy on 2022/2/15.
//

import SwiftUI

public struct ReceiveChatView: View {
    @ObservedObject private var service: RPService = .shared
    @State private var isOpened: Bool = false
    @State private var showReceive: Bool = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ChatTopView(avatar: "👱🏻", name: "Alex")
                
                GeometryReader { _ in
                    ChatListView(
                        isOpened: $isOpened,
                        showSend: .constant(false),
                        showReceive: $showReceive,
                        playMode: .receive
                    )
                }
                
                ChatBottomView(isOpened: $isOpened, playMode: .receive)
            }
            
            if showReceive {
                RPReceiveContentView(showReceive: $showReceive, isOpened: $isOpened)
            }
        }
    }
}
