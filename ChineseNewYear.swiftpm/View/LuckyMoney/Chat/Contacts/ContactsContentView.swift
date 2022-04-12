//
//  ContactsContentView.swift
//  
//
//  Created by roy on 2022/4/11.
//

import SwiftUI

struct ContactsContentView: View {
    @ObservedObject private var service: RPService = .shared
    @State private var introText: AttributedString?
    @State private var showIntro: Bool = true
    
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
        .navigationTitle(showIntro ? "" : "Chats")
        .navigationBarTitleDisplayMode(.large)
        .overlay {
            Group {
                if let introText = introText {
                    Text(introText)
                } else {
                    Text("Error displaying intro.")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.white)
            .padding(.horizontal)
        }
        .onAppear {
            if
                let introUrl = Bundle.main.url(forResource: "chats", withExtension: "rtf", subdirectory: "Docs"),
                let nsAttr = try? NSAttributedString(
                    url: introUrl,
                    options: [.documentType: NSAttributedString.DocumentType.rtf],
                    documentAttributes: nil
                )
            {
                introText = try? AttributedString(nsAttr, including: \.uiKit)
            }
        }
    }
}

struct ContactsContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsContentView()
    }
}
