import SwiftUI

struct ContentView: View {
    @State private var showPicker = false
    @State private var showDetail = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Menu {
                    Button {
                        selectedImage = .init(named: "fake_info1")
                    } label: {
                        Label("Fake Info", systemImage: "person.circle")
                    }
                    
                    Button {
                        selectedImage = .init(named: "fake_passport")
                    } label: {
                        Label("Fake Passport", systemImage: "person.text.rectangle")
                    }
                    
                    Button {
                        selectedImage = .init(named: "fake_form")
                    } label: {
                        Label("Fake Form", systemImage: "doc.richtext")
                    }
                } label: {
                    Label("Select a sample", systemImage: "photo")
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
                    Label("Choose from Photo Library", systemImage: "photo.on.rectangle.angled")
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
