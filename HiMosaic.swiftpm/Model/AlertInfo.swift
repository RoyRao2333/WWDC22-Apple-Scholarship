//
//  AlertInfo.swift
//  
//
//  Created by roy on 2022/4/21.
//

import Foundation

struct AlertInfo: Identifiable {
    let id: AlertType
    let title: String
    let message: String
    
    enum AlertType {
        case success
        case failure
    }
}
