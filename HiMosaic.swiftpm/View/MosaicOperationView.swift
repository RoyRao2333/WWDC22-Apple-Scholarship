//
//  MosaicOperationView.swift
//  
//
//  Created by Roy Rao on 2022/4/20.
//

import SwiftUI
import Vision

struct MosaicOperationView: View {
    @ObservedObject private var service: HMService = .shared
    @State private var bName = false
    @State private var bNumber = false
    @State private var bPhoneNumber = false
    @State private var bEmail = false
    @State private var bUrl = false
    @State private var bCreditCardNumber = false
    
    var imageView: some View {
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
    }
    
    var body: some View {
        ZStack {
            VStack {
                imageView
                
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
                
                Spacer()
                
                Button(action: exportImage) {
                    HStack {
                        Image(systemName: "tray.and.arrow.down")
                        
                        Text("Save to Photo Library")
                    }
                    .padding(20)
                    .background(Color.blue.opacity(0.2), in: RoundedRectangle(cornerRadius: 10))
                }
                .alert(item: $service.alert) {
                    Alert(
                        title: Text($0.title),
                        message: Text($0.message),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                Spacer()
                    .frame(height: 50)
            }
            
            if service.textItems.isEmpty {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(.ultraThinMaterial)
            }
        }
        .navigationTitle("Workspace")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            service.recognizeText(in: UIImage(named: "fake_info"))
        }
        .onChange(of: bName) { newValue in
            $service.textItems.filter { $item in
                item.types.contains(RegexPattern.name)
            }.forEach { $item in
                item.validated = newValue
            }
        }
        .onChange(of: bNumber) { newValue in
            $service.textItems.filter { $item in
                item.types.contains(RegexPattern.number)
            }.forEach { $item in
                item.validated = newValue
            }
        }
        .onChange(of: bPhoneNumber) { newValue in
            $service.textItems.filter { $item in
                item.types.contains(RegexPattern.phoneNumber)
            }.forEach { $item in
                item.validated = newValue
            }
        }
        .onChange(of: bEmail) { newValue in
            $service.textItems.filter { $item in
                item.types.contains(RegexPattern.email)
            }.forEach { $item in
                item.validated = newValue
            }
        }
        .onChange(of: bUrl) { newValue in
            $service.textItems.filter { $item in
                item.types.contains(RegexPattern.url)
            }.forEach { $item in
                item.validated = newValue
            }
        }
        .onChange(of: bCreditCardNumber) { newValue in
            $service.textItems.filter { $item in
                item.types.contains(RegexPattern.creditCardNumber)
            }.forEach { $item in
                item.validated = newValue
            }
        }
    }
    
    private func exportImage() {
        UIImageWriteToSavedPhotosAlbum(
            imageView.snapshot(),
            service,
            #selector(service.saveImage),
            nil
        )
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MosaicOperationView()
    }
}
