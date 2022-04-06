//
//  RedPackageModel.swift
//
//  Created by roy on 2022/2/22.
//

import Foundation

public struct RedPackageModel {
    
    public init(
        isMine: Bool,
        senderName: String,
        senderAvatar: String,
        msg: String,
        amount: String,
        receiverName: String,
        receiverAvatar: String
    ) {
        self.isMine = isMine
        self.senderName = senderName
        self.senderAvatar = senderAvatar
        self.msg = msg
        self.amount = amount
        self.receiverName = receiverName
        self.receiverAvatar = receiverAvatar
    }
    
    public init() {
        self.isMine = true
        self.senderName = ""
        self.senderAvatar = ""
        self.msg = ""
        self.amount = ""
        self.receiverName = ""
        self.receiverAvatar = ""
    }
    
    var isMine: Bool
    
    var senderName: String
    var senderAvatar: String
    var msg: String
    var amount: String
    
    var receiverName: String
    var receiverAvatar: String
}
