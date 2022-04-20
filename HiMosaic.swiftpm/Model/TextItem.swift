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
    let type: RegexPattern?
    var validated: Bool
    
    init(text: String?, normalizedRect: CGRect, type: RegexPattern? = nil, validated: Bool = false) {
        self.text = text
        self.normalizedRect = normalizedRect
        self.type = type
        self.validated = validated
    }
}
