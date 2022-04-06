import SwiftUI

struct MainContentView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    ReceiveChatView(model: RedPackageModel(
                        isMine: false,
                        senderName: "Alex",
                        senderAvatar: "👱🏻",
                        msg: "Best Wishes to you, \("Roy")! Without your help, I couldn't have won the scholarship. You are my best buddy, happy New Year!",
                        amount: "500",
                        receiverName: "Roy",
                        receiverAvatar: "🧑🏻‍💻"
                    ))
                } label: {
                    Label("Lucky Money", systemImage: "1.square")
                }
                
                NavigationLink {
                    
                } label: {
                    Label("Reunion Dinnder", systemImage: "2.square")
                }
                
                NavigationLink {
                    FireworksContentView()
                } label: {
                    Label("Fireworks", systemImage: "3.square")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Chapters")
            
            Text("Choose a chapter from Chapters menu!")
                .font(.title)
        }
    }
}
