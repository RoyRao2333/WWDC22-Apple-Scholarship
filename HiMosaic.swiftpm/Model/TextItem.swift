//
//  TextItem.swift
//  
//
//  Created by roy on 2022/4/18.
//

import Foundation

class TextItem: Identifiable {
    let id = UUID().uuidString
    var text: String
    
    init(text: String) {
        self.text = text
    }
}
