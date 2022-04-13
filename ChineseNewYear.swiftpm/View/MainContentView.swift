import SwiftUI

struct MainContentView: View {
    @State private var orientation: UIDeviceOrientation = .unknown
    @State private var introText: AttributedString?
    
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
            
            ScrollView {
                ZStack {
                    GeometryReader { geo in
                        Image("chinese_knot")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .position(x: geo.size.width / 4 * 3, y: geo.size.height / 6)
                            .opacity(0.3)
                    }
                    
                    Group {
                        if let introText = introText {
                            Text(introText)
                        } else {
                            Text("Error displaying intro.")
                        }
                    }
                    .foregroundColor(.white)
                }
                .padding()
            }
            .background(Color.white)
        }
        .onAppear {
            if
                let introUrl = Bundle.main.url(forResource: "intro", withExtension: "rtf", subdirectory: "Docs"),
                let nsAttr = try? NSAttributedString(
                    url: introUrl,
                    options: [.documentType: NSAttributedString.DocumentType.rtf],
                    documentAttributes: nil
                )
            {
                introText = try? AttributedString(nsAttr, including: \.uiKit)
            }
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
