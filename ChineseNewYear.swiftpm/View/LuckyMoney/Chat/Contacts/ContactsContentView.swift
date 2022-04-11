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
                ReceiveChatView()
            } label: {
                ContactsListRowView(avatar: "👱🏻", name: "Alex")
            }
            
            NavigationLink {
                SendChatView()
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
