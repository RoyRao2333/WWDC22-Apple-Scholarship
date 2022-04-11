import SwiftUI

struct MainContentView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    ContactsContentView()
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
