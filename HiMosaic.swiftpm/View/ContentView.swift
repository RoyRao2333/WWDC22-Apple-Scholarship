import SwiftUI

struct ContentView: View {
    @State private var showPicker = false
    @State private var showDetail = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button {
                    selectedImage = .init(named: "fake_info")
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
                
                Button {
                    withAnimation {
                        showPicker = true
                    }
                } label: {
                    HStack {
                        Image(systemName: "photo.on.rectangle.angled")
                        
                        Text("Choose from Photo Library")
                    }
                    .padding(20)
                    .background(Color.blue.opacity(0.2), in: RoundedRectangle(cornerRadius: 10))
                }
                .sheet(isPresented: $showPicker) {
                    PhotoPicker(image: $selectedImage)
                }
                
                NavigationLink(
                    destination: MosaicOperationView(image: $selectedImage),
                    isActive: $showDetail
                ) { EmptyView() }
            }
            .navigationTitle("HiMosaic")
            .navigationBarTitleDisplayMode(.large)
            .onChange(of: selectedImage) { newValue in
                withAnimation {
                    showDetail = newValue != nil
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
