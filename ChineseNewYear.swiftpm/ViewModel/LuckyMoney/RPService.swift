//
//  RPService.swift
//
//  Created by roy on 2022/2/16.
//

import Foundation

public class RPService: ObservableObject {
    public static let shared = RPService()
    
    @Published public var yourNickName: String = "Roy"
    @Published public var myRedPacketModel: RedPacketModel?
    
    public lazy var alexRedPacketModel = RedPacketModel(
        isMine: false,
        senderName: "Alex",
        senderAvatar: "👱🏻",
        msg: "Best Wishes to you, \(yourNickName)! Without your help, I couldn't have won the scholarship. You are my best buddy, happy New Year!",
        amount: "500",
        receiverName: yourNickName,
        receiverAvatar: "🧑🏻‍💻"
    )
    
    private init() {}
}
