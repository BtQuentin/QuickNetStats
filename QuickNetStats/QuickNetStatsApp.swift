//
//  QuickNetStatsApp.swift
//  QuickNetStats
//
//  Created by Federico Imberti on 2025-11-07.
//

import SwiftUI

@main
struct QuickNetStatsApp: App {
    var body: some Scene {
        MenuBarExtra(content: {
            ContentView()
            .padding()
            .frame(width: 550)

        }, label: {
            Label("Quick Net Stas", systemImage: "network")
        })
        .menuBarExtraStyle(.window)
    }
}
