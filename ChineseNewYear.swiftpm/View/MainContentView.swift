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
            
            Group {
                if let introText = introText {
                    Text(introText)
                } else {
                    Text("Error displaying intro.")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(.horizontal)
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
