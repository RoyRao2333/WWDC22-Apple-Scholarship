//
//  MsgBox.swift
//
//  Created by roy on 2022/2/15.
//

import SwiftUI

struct MsgBox: Shape {
    var isMine: Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [
                .bottomLeft,
                .bottomRight,
                isMine ? .topLeft : .topRight
            ],
            cornerRadii: CGSize(width: 25, height: 25)
        )
        
        return Path(path.cgPath)
    }
}
