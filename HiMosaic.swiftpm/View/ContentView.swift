import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink {
                    MosaicOperationView()
                } label: {
                    HStack {
                        Image(systemName: "photo")
                        
                        Text("Select a sample")
                    }
                    .padding(20)
                    .background(Color.blue.opacity(0.2), in: RoundedRectangle(cornerRadius: 10))
                }
                
                Divider()
                    .frame(width: 300)
                
                NavigationLink {
                    
                } label: {
                    HStack {
                        Image(systemName: "photo.on.rectangle.angled")
                        
                        Text("Choose from Photo Library")
                    }
                    .padding(20)
                    .background(Color.blue.opacity(0.2), in: RoundedRectangle(cornerRadius: 10))
                }
            }
            .navigationTitle("HiMosaic")
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(.stack)
    }
}
