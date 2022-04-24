//
//  SwiftUIView.swift
//  
//
//  Created by Roy Rao on 2022/4/24.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject private var service: HMService = .shared
    @Binding var showWelcome: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 20) {
                Group {
                    Text("Welcome to ")
                        .foregroundColor(.primary)
                    
                    +
                    
                    Text("HiMosaic")
                        .foregroundColor(.teal)
                }
                .font(.title.bold())
                
                HStack(spacing: 20) {
                    Image(systemName: "lock.shield")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.teal)
                    
                    Text("Protect your privacy by importing photos and put on mosaics. \nOperations are done fully offline.")
                        .font(.headline)
                }
                
                HStack(spacing: 20) {
                    Image(systemName: "eyeglasses")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.teal)
                    
                    Text("We're able to detect all the texts in your photos, then put on mosaics automatically. \nThere're many filters you can play with!")
                        .font(.headline)
                }
                
                HStack(spacing: 20) {
                    Image(systemName: "hand.tap")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.teal)
                    
                    Text("Not quite accurate? \nYou can always tap on the texts and put on mosaics manually.")
                        .font(.headline)
                }
                
                HStack(spacing: 20) {
                    Image(systemName: "square.and.arrow.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.teal)
                    
                    Text("Save the edited copy to your Photo Library when it's done!")
                        .font(.headline)
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            Button {
                withAnimation(.easeInOut) {
                    showWelcome = false
                    service.onStartup = false
                }
            } label: {
                Image(systemName: "chevron.compact.down")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
    }
}
