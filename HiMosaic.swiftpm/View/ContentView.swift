import SwiftUI
import Vision

struct ContentView: View {
    @ObservedObject private var service: HMService = .shared
    @State private var bName = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("fake_info")
                    .resizable()
                    .scaledToFit()
                    .overlay {
                        GeometryReader { geo in
                            ForEach($service.textItems, id: \.self) { $item in
                                Rectangle()
                                    .path(in: VNImageRectForNormalizedRect(
                                        item.normalizedRect,
                                        Int(geo.size.width),
                                        Int(geo.size.height)
                                    ))
                                    .fill(item.validated ? Color.gray : .black.opacity(0.0001))
                                    .onTapGesture {
                                        item.validated.toggle()
                                    }
                            }
                        }
                    }
                
                Toggle("Name", isOn: $bName)
                    .toggleStyle(CheckboxToggleStyle(style: .square))
                    .foregroundColor(.blue)
            }
            .listStyle(.sidebar)
            .navigationTitle("HiMosaic")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                service.recognizeText(in: UIImage(named: "fake_info"))
            }
            .onChange(of: bName) { newValue in
                let nameItems = $service.textItems.filter { $item in
                    item.type == RegexPattern.name
                }
                nameItems.forEach { $item in
                    item.validated = newValue
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
