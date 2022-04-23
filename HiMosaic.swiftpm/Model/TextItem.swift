//
//  TextItem.swift
//  
//
//  Created by roy on 2022/4/18.
//

import UIKit

struct TextItem: Identifiable, HashableSynthesizable {
    let id = UUID().uuidString
    let text: String?
    let normalizedRect: CGRect
    
    init(text: String?, normalizedRect: CGRect) {
        self.text = text
        self.normalizedRect = normalizedRect
    }
}
