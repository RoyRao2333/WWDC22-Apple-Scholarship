//
//  FireworksContentView.swift
//  PlaygroundBook
//
//  Created by roy on 2022/2/25.
//

import SwiftUI

public struct FireworksContentView: View {
    
    public init() {}
    
    public var body: some View {
        GeometryReader { geo in
            EmitterView(frameSize: geo.size)
        }
        .background(Color.black)
    }
}

struct FireworksContentView_Previews: PreviewProvider {
    static var previews: some View {
        FireworksContentView()
    }
}
