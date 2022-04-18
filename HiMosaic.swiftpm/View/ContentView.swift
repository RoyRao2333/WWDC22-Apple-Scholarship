import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            List {
                
            }
            .listStyle(.sidebar)
            .navigationTitle("HiMosaic")
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(.stack)
    }
}
