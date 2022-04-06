//
//  RPReceiptCellView.swift
//
//  Created by roy on 2022/2/22.
//

import SwiftUI

struct RPReceiptCellView: View {
    var model: RedPackageModel
    
    var body: some View {
        HStack(spacing: 10) {
            Text(model.receiverAvatar)
                .font(.system(size: 40))
            
            VStack(alignment: .leading, spacing: 0) {
                Text(model.receiverName)
                    .font(.system(size: 30))
                    .foregroundColor(Color(hex: "161616"))
                
                Text(Date().formatted("HH:mm"))
                    .font(.system(size: 20))
                    .foregroundColor(Color(hex: "B5B5B5"))
            }
            
            Spacer()
            
            Text("¥ ")
                .foregroundColor(Color(hex: "161616"))
                .font(.system(size: 30))
            
            +
            
            Text(model.amount)
                .foregroundColor(Color(hex: "161616"))
                .font(.system(size: 30))
        }
    }
}
