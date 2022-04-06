//
//  ChatRPCellView.swift
//
//  Created by roy on 2022/2/22.
//

import SwiftUI

struct ChatRPCellView: View {
    @Binding var showSend: Bool
    @Binding var showReceive: Bool
    @Binding var isOpened: Bool
    
    var model: RedPackageModel
    var playMode: RPPlayMode
    
    var body: some View {
        HStack {
            if model.isMine {
                Spacer()
            }
            
            HStack(alignment: .center, spacing: 10) {
                if !model.isMine {
                    VStack {
                        Text(model.senderAvatar)
                            .font(.system(size: 50))
                        
                        Text(model.senderName)
                            .font(.system(size: 20))
                    }
                    .foregroundColor(Color(hex: "161616"))
                }
                
                if !isOpened {
                    RPUntappedThumbnailView(
                        showReceive: $showReceive,
                        message: model.msg,
                        playMode: playMode
                    )
                    .frame(maxWidth: 450)
                } else {
                    RPTappedThumbnailView(model: model)
                        .frame(maxWidth: 450)
                }
                
                if model.isMine {
                    VStack {
                        Text(model.senderAvatar)
                            .font(.system(size: 50))
                        
                        Text(model.senderName)
                            .font(.system(size: 20))
                    }
                    .foregroundColor(Color(hex: "161616"))
                }
            }
            
            
            if !model.isMine {
                Spacer()
            }
        }
        .padding(model.isMine ? .leading : .trailing, 55)
        .padding(.vertical, 10)
    }
}
