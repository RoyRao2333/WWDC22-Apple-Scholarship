//
//  RPService.swift
//
//  Created by roy on 2022/2/16.
//

import Foundation

public class RPService: ObservableObject {
    public static let shared = RPService()
    
    @Published public var yourNickName: String = "Roy"
    
    private init() {}
}
