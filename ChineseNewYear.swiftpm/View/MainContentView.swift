import SwiftUI

struct MainContentView: View {
    @State private var orientation: UIDeviceOrientation = .unknown
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    ContactsContentView()
                } label: {
                    Label("Chats", systemImage: "1.square")
                }
                
                NavigationLink {
                    
                } label: {
                    Label("Recipes", systemImage: "2.square")
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
        .onRotate { ori in
            orientation = ori
        }
        .overlay {
            if orientation == .landscapeLeft || orientation == .landscapeRight {
                Text("Please rotate your iPad to portrait mode in order to have a better experience.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .padding(.horizontal, 20)
                    .background(Color.white)
            }
        }
    }
}
