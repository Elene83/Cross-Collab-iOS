//
//  EventTitleText.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct EventTitleText: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.appDarkGray)
            .lineLimit(2)
    }
}
