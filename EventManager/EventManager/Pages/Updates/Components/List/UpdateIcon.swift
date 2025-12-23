//
//  UpdateIcon.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct UpdateIcon: View {
    let systemName: String
    
    var body: some View {
        Image(systemName: systemName)
            .font(.system(size: 20))
            .foregroundColor(.appViolet)
            .frame(width: 32, height: 32)
            .clipShape(Circle())
    }
}

#Preview {
    UpdatesView()
}
