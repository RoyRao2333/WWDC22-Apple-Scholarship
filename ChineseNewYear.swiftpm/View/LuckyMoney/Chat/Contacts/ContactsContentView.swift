//
//  ContactsContentView.swift
//  
//
//  Created by roy on 2022/4/11.
//

import SwiftUI

struct ContactsContentView: View {
    @ObservedObject private var service: RPService = .shared
    
    var body: some View {
        List {
            NavigationLink {
                ReceiveChatView(model: RedPackageModel(
                    isMine: false,
                    senderName: "Alex",
                    senderAvatar: "👱🏻",
                    msg: "Best Wishes to you, \(service.yourNickName)! Without your help, I couldn't have won the scholarship. You are my best buddy, happy New Year!",
                    amount: "500",
                    receiverName: service.yourNickName,
                    receiverAvatar: "🧑🏻‍💻"
                ))
            } label: {
                ContactsListRowView(avatar: "👱🏻", name: "Alex")
            }
            
            NavigationLink {
                Text("Hello World.")
            } label: {
                ContactsListRowView(avatar: "👱🏻‍♀️", name: "Lisa")
            }
        }
        .listStyle(.plain)
        .navigationTitle("Chats")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ContactsContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsContentView()
    }
}
