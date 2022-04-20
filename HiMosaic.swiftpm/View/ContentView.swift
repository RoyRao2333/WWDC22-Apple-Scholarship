import SwiftUI
import Vision

struct ContentView: View {
    @ObservedObject private var service: HMService = .shared
    @State private var bName = false
    @State private var bNumber = false
    @State private var bPhoneNumber = false
    @State private var bEmail = false
    @State private var bUrl = false
    @State private var bCreditCardNumber = false
    
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
                
                VStack(alignment: .leading, spacing: 10) {
                    Toggle("Names", isOn: $bName)
                        .toggleStyle(CheckboxToggleStyle(style: .square))
                        .foregroundColor(.blue)
                    
                    Toggle("Numbers", isOn: $bNumber)
                        .toggleStyle(CheckboxToggleStyle(style: .square))
                        .foregroundColor(.blue)
                    
                    Toggle("Phone Numbers", isOn: $bPhoneNumber)
                        .toggleStyle(CheckboxToggleStyle(style: .square))
                        .foregroundColor(.blue)
                    
                    Toggle("Emails", isOn: $bEmail)
                        .toggleStyle(CheckboxToggleStyle(style: .square))
                        .foregroundColor(.blue)
                    
                    Toggle("URLs", isOn: $bUrl)
                        .toggleStyle(CheckboxToggleStyle(style: .square))
                        .foregroundColor(.blue)
                    
                    Toggle("Credit Card Numbers", isOn: $bCreditCardNumber)
                        .toggleStyle(CheckboxToggleStyle(style: .square))
                        .foregroundColor(.blue)
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("HiMosaic")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                service.recognizeText(in: UIImage(named: "fake_info"))
            }
            .onChange(of: bName) { newValue in
                $service.textItems.filter { $item in
                    item.type == RegexPattern.name
                }.forEach { $item in
                    item.validated = newValue
                }
            }
            .onChange(of: bNumber) { newValue in
                $service.textItems.filter { $item in
                    item.type == RegexPattern.number
                }.forEach { $item in
                    item.validated = newValue
                }
            }
            .onChange(of: bPhoneNumber) { newValue in
                $service.textItems.filter { $item in
                    item.type == RegexPattern.phoneNumber
                }.forEach { $item in
                    item.validated = newValue
                }
            }
            .onChange(of: bEmail) { newValue in
                $service.textItems.filter { $item in
                    item.type == RegexPattern.email
                }.forEach { $item in
                    item.validated = newValue
                }
            }
            .onChange(of: bUrl) { newValue in
                $service.textItems.filter { $item in
                    item.type == RegexPattern.url
                }.forEach { $item in
                    item.validated = newValue
                }
            }
            .onChange(of: bCreditCardNumber) { newValue in
                $service.textItems.filter { $item in
                    item.type == RegexPattern.creditCardNumber
                }.forEach { $item in
                    item.validated = newValue
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
