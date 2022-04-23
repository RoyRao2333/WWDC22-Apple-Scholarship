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
    @State private var bAllText = false
    @State private var bName = false
    @State private var bNumber = false
    @State private var bPhoneNumber = false
    @State private var bEmail = false
    @State private var bUrl = false
    @State private var bCreditCardNumber = false
    @State private var bPassportNumber = false
    @State private var selectedItems: Set<TextItem> = []
    
    @Binding var image: UIImage?
    
    var imageView: some View {
        Image(uiImage: image ?? UIImage())
            .resizable()
            .scaledToFit()
            .overlay {
                GeometryReader { geo in
                    ForEach(service.rawTextItems, id: \.self) { item in
                        let frame = VNImageRectForNormalizedRect(
                            item.normalizedRect,
                            Int(geo.size.width),
                            Int(geo.size.height)
                        )
//
//                        Text(item.text ?? "N/A")
//                            .foregroundColor(.red)
//                            .position(x: frame.midX, y: frame.origin.y)
                        
                        Rectangle()
                            .path(in: frame)
                            .fill(Color.black.opacity(0.0001))
                            .onTapGesture {
                                selectedItems.insert(item)
                            }
                    }
                    
                    ForEach(Array(selectedItems), id: \.self) { item in
                        let frame = VNImageRectForNormalizedRect(
                            item.normalizedRect,
                            Int(geo.size.width),
                            Int(geo.size.height)
                        )
                        
                        Rectangle()
                            .path(in: frame)
                            .fill(Color.gray)
                            .onTapGesture {
                                selectedItems.remove(item)
                            }
                    }
                }
            }
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("If the result provided below is not accurate, you can always tap the texts on the image and manually put on mosaic.")
                    .multilineTextAlignment(.center                             )
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.teal, in: RoundedRectangle(cornerRadius: 10))
                    .padding()
                
                imageView
                
                VStack(alignment: .leading, spacing: 10) {
                    Toggle("All Text", isOn: $bAllText)
                        .toggleStyle(CheckboxToggleStyle(style: .square))
                        .foregroundColor(.blue)
                    
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
                    
                    Toggle("Passport Numbers", isOn: $bPassportNumber)
                        .toggleStyle(CheckboxToggleStyle(style: .square))
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Button(action: exportImage) {
                    Label("Save to Photo Library", systemImage: "tray.and.arrow.down")
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
            
            if service.rawTextItems.isEmpty {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(.ultraThinMaterial)
            }
        }
        .navigationTitle("Workspace")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            service.recognizeText(in: image)
        }
        .onDisappear {
            image = nil
        }
        .onChange(of: bAllText) { newValue in
            selectedItems = newValue ? Set(service.rawTextItems) : []
            if !newValue {
                bName = false
                bNumber = false
                bPhoneNumber = false
                bEmail = false
                bUrl = false
                bCreditCardNumber = false
                bPassportNumber = false
            }
        }
        .onChange(of: bName) { newValue in
            if newValue {
                selectedItems = selectedItems.union(service.nameItems)
            } else {
                service.nameItems.forEach { selectedItems.remove($0) }
            }
        }
        .onChange(of: bNumber) { newValue in
            if newValue {
                selectedItems = selectedItems.union(service.numberItems)
            } else {
                service.numberItems.forEach { selectedItems.remove($0) }
            }
        }
        .onChange(of: bPhoneNumber) { newValue in
            if newValue {
                selectedItems = selectedItems.union(service.phoneNumberItems)
            } else {
                service.phoneNumberItems.forEach { selectedItems.remove($0) }
            }
        }
        .onChange(of: bEmail) { newValue in
            if newValue {
                selectedItems = selectedItems.union(service.emailItems)
            } else {
                service.emailItems.forEach { selectedItems.remove($0) }
            }
        }
        .onChange(of: bUrl) { newValue in
            if newValue {
                selectedItems = selectedItems.union(service.urlItems)
            } else {
                service.urlItems.forEach { selectedItems.remove($0) }
            }
        }
        .onChange(of: bCreditCardNumber) { newValue in
            if newValue {
                selectedItems = selectedItems.union(service.creditCardNumberItems)
            } else {
                service.creditCardNumberItems.forEach { selectedItems.remove($0) }
            }
        }
        .onChange(of: bPassportNumber) { newValue in
            if newValue {
                selectedItems = selectedItems.union(service.passportNumberItems)
            } else {
                service.passportNumberItems.forEach { selectedItems.remove($0) }
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
