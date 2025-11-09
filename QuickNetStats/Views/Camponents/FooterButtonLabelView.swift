//
//  FooterButtonView.swift
//  QuickNetStats
//
//  Created by Federico Imberti on 2025-11-09.
//

import SwiftUI

struct FooterButtonLabelView: View {
    
    let labelText:String
    let systemName:String
    
    var body: some View {
        Button {
            
        } label: {
            Label {
                Text(labelText)
                    .font(.system(size: 14, weight: .semibold))
            } icon: {
                Image(systemName: systemName)
                    .font(.system(size: 14, weight: .bold))
            }
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
    }
}

#Preview {
    
    var selected = false
    
    FooterButtonLabelView(labelText: "Quit", systemName: "power")
    FooterButtonLabelView(labelText: "Quit", systemName: "power")
}
