//
//  ContactsListRowView.swift
//  
//
//  Created by roy on 2022/4/11.
//

import SwiftUI

struct ContactsListRowView: View {
    var avatar: String
    var name: String
    
    var body: some View {
        HStack(spacing: 20) {
            Text(avatar)
                .font(.system(size: 30))
                .padding(8)
                .background(Color(hex: "76C6D4"))
                .clipShape(Circle())
            
            Text(name)
                .font(.headline)
        }
    }
}

struct ContactsListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsContentView()
    }
}
