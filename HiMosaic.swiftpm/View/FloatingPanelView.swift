//
//  SwiftUIView.swift
//  
//
//  Created by Roy Rao on 2022/4/24.
//

import SwiftUI

struct FloatingPanelView: View {
    @State private var showPanel = false
    @Binding var bAllText: Bool
    @Binding var bName: Bool
    @Binding var bNumber: Bool
    @Binding var bPhoneNumber: Bool
    @Binding var bEmail: Bool
    @Binding var bUrl: Bool
    @Binding var bCreditCardNumber: Bool
    
    var exportImage: () -> Void
    
    var body: some View {
        VStack(alignment: .trailing) {
            if showPanel {
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
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                .transition(.move(edge: .trailing))
            }
            
            HStack(spacing: 10) {
                Button(action: exportImage) {
                    Image(systemName: "square.and.arrow.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color.blue, in: Circle())
                }
                
                Button {
                    withAnimation(.easeInOut) {
                        showPanel.toggle()
                    }
                } label: {
                    Image(systemName: showPanel ? "multiply" : "pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color.blue, in: Circle())
                }
            }
        }
    }
}

struct FloatingPanelView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingPanelView(bAllText: .constant(true), bName: .constant(true), bNumber: .constant(true), bPhoneNumber: .constant(true), bEmail: .constant(true), bUrl: .constant(true), bCreditCardNumber: .constant(true), exportImage: {})
    }
}
