import SwiftUI

struct ContentView: View {
    @ObservedObject private var service: HMService = .shared
    
    var body: some View {
        NavigationView {
            VStack {
                Image("sample_fakeinfo")
                    .resizable()
                    .scaledToFit()
                
                Text(service.textItems.map { $0.text }.joined(separator: "\n"))
            }
            .listStyle(.sidebar)
            .navigationTitle("HiMosaic")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                service.recognizeText(in: UIImage(named: "sample_fakeinfo"))
            }
        }
        .navigationViewStyle(.stack)
    }
}
