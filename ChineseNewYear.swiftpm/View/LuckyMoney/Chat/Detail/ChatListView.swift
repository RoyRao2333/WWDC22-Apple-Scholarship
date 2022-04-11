//
//  ChatListView.swift
//
//  Created by roy on 2022/2/15.
//

import SwiftUI

struct ChatListView: View {
    @ObservedObject private var service: RPService = .shared
    @Binding var isOpened: Bool
    @Binding var showSend: Bool
    @Binding var showReceive: Bool
    
    var model: RedPackageModel
    var playMode: RPPlayMode
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            switch playMode {
                case .send:
                    // Your Red Packet
                    if !showSend {
                        ChatRPCellView(
                            showSend: $showSend,
                            showReceive: $showReceive,
                            isOpened: $isOpened,
                            model: model,
                            playMode: playMode
                        )
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                isOpened = true
                            }
                        }
                        
                        ChatCellView(model: ChatModel(isMine: false, msg: "Thanks, honey! I'm so glad to have you with me~", avatar: "👱🏻‍♀️", name: "Lisa"))
                            .isHidden(!isOpened)
                    }
                    
                case .receive:
                    // Alex's Red Packet
                    ChatRPCellView(
                        showSend: $showSend,
                        showReceive: $showReceive,
                        isOpened: $isOpened,
                        model: model,
                        playMode: playMode
                    )
                    
                    ChatCellView(model: ChatModel(isMine: true, msg: "That's very kind of you, Alex! Best buddy forever!", avatar: "🧑🏻‍💻", name: service.yourNickName))
                        .isHidden(!isOpened || showReceive)
            }
        }
        .padding(.horizontal, 15)
        .background(Color.white)
//        .onChange(of: showSend) { newValue in
//            if playMode == .send, !newValue {
//                PlaygroundPage.current.assessmentStatus = .pass(message: "### Congrats! \nYou've successfully sent a Red Packet to Lisa, and received her gratitude! \n\nYou can now tap the Red Packet above to see the details. \n\nAfter that, you may receive and open a Red Packet by proceeding to the [**Next Page**](@next)!")
//            }
//        }
//        .onChange(of: showReceive) { newValue in
//            if playMode == .receive, !newValue {
//                PlaygroundPage.current.assessmentStatus = .pass(message: "### Congrats! \nYou received and opened the Red Packet that Alex sent you. Did you have fun? \n\nYou can now tap the Red Packet above to see the details and then proceed to the [**Next Chapter**](@next)!")
//            }
//        }
    }
}
