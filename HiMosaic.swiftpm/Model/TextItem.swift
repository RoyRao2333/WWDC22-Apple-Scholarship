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
    let types: [RegexPattern]
    var validated: Bool
    
    init(text: String?, normalizedRect: CGRect, types: [RegexPattern] = [], validated: Bool = false) {
        self.text = text
        self.normalizedRect = normalizedRect
        self.types = types
        self.validated = validated
    }
}
