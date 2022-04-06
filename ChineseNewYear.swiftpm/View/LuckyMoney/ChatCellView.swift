//
//  ChatCellView.swift
//
//  Created by roy on 2022/2/15.
//

import SwiftUI

struct ChatCellView: View {
    var model: ChatModel
    
    var body: some View {
        HStack {
            if model.isMine {
                Spacer()
            }
            
            HStack(alignment: .center, spacing: 5) {
                if !model.isMine {
                    VStack {
                        Text(model.avatar)
                            .font(.system(size: 50))
                        
                        Text(model.name)
                            .font(.system(size: 20))
                    }
                    .foregroundColor(Color(hex: "161616"))
                }
                
                VStack(alignment: (model.isMine ? .trailing : .leading), spacing: 5) {
                    Text(model.msg)
                        .font(.system(size: 20))
                        .foregroundColor(
                            model.isMine
                                ? Color.white
                                : Color(hex: "#161616")
                        )
                        .padding()
                        .background(
                            model.isMine
                                ? Color(hex: "#4284F6")
                                : Color(hex: "#E9E9EB")
                        )
                        .clipShape(MsgBox(isMine: model.isMine))
                }
                
                if model.isMine {
                    VStack {
                        Text(model.avatar)
                            .font(.system(size: 50))
                        
                        Text(model.name)
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
        .padding(.vertical, 5)
    }
}
