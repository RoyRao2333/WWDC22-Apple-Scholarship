//
//  HMService.swift
//  
//
//  Created by roy on 2022/4/18.
//

import Foundation

class HMService: ObservableObject {
    static let shared = HMService()
    
    @Published var textItems: [TextItem] = []
    
    private init() {}
}
