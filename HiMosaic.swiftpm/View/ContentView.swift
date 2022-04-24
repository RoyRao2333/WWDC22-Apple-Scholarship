import SwiftUI

struct ContentView: View {
    @ObservedObject private var service: HMService = .shared
    @State private var showPicker = false
    @State private var showDetail = false
    @State private var selectedImage: UIImage?
    @State private var showWelcome = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(spacing: 20) {
                    Menu {
                        Button {
                            selectedImage = .init(named: "fake_info")
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
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                if showWelcome {
                    WelcomeView(showWelcome: $showWelcome)
                        .transition(.move(edge: .bottom))
                }
            }
            .navigationTitle("HiMosaic")
            .navigationBarTitleDisplayMode(.large)
            .onChange(of: selectedImage) { newValue in
                withAnimation {
                    showDetail = newValue != nil
                }
            }
            .onAppear {
                if service.onStartup {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.easeInOut) {
                            showWelcome = true
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
