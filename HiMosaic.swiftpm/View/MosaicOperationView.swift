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
    @State private var bNumber = false
    @State private var bPhoneNumber = false
    @State private var bEmail = false
    @State private var bUrl = false
    @State private var bCreditCardNumber = false
    @State private var showDesc = true
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
            ZStack(alignment: .center) {
                imageView
                
                GeometryReader { geo in
                    FloatingPanelView(
                        bAllText: $bAllText,
                        bNumber: $bNumber,
                        bPhoneNumber: $bPhoneNumber,
                        bEmail: $bEmail,
                        bUrl: $bUrl,
                        bCreditCardNumber: $bCreditCardNumber,
                        exportImage: exportImage
                    )
                    .padding([.trailing, .bottom])
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height,
                        alignment: .bottomTrailing
                    )
                    .alert(item: $service.alert) {
                        Alert(
                            title: Text($0.title),
                            message: Text($0.message),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
            }
            
            if showDesc {
                VStack {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(alignment: .top) {
                            Image(systemName: "slider.horizontal.3")
                            
                            Text("Use the filter button at the bottom to put on mosaic automatically.")
                                .multilineTextAlignment(.leading)
                        }
                        
                        HStack(alignment: .top) {
                            Image(systemName: "hand.tap.fill")
                            
                            Text("Tap on the texts on the image to manually put on mosaic.")
                                .multilineTextAlignment(.leading)
                        }
                        
                        HStack(alignment: .top) {
                            Image(systemName: "square.and.arrow.down.fill")
                            
                            Text("After finishing editing, you can save the photo to Photo Library.")
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .foregroundColor(.white)
                    
                    Button {
                        withAnimation {
                            showDesc = false
                        }
                    } label: {
                        Text("Got it!")
                            .foregroundColor(.primary)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 20)
                            .background(.ultraThinMaterial, in: Capsule())
                    }
                }
                .padding(20)
                .background(Color.teal, in: RoundedRectangle(cornerRadius: 10))
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .transition(.move(edge: .top))
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
                bNumber = false
                bPhoneNumber = false
                bEmail = false
                bUrl = false
                bCreditCardNumber = false
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
    }
    
    private func exportImage() {
        UIImageWriteToSavedPhotosAlbum(
            imageView.snapshot,
            service,
            #selector(service.saveImage),
            nil
        )
    }
}
