//
//  SettingsView.swift
//  QuickNetStats
//
//  Created by Federico Imberti on 2025-11-11.
//

import SwiftUI

enum UserDefaultsKeys {
    static let showSummary = "showSummary"
    static let useAnimations = "useAnimations"
}

struct SettingsView: View {
    
    @StateObject var vm: SettingsViewModel
    
    @AppStorage(UserDefaultsKeys.showSummary)
    private var showSummary: Bool = true
    
    @AppStorage(UserDefaultsKeys.useAnimations)
    private var useAnimations: Bool = NSWorkspace.shared.accessibilityDisplayShouldReduceMotion
    
    init(isSettingViewOpened: Binding<Bool>) {
        _vm = .init(wrappedValue: SettingsViewModel(isSettingViewOpened: isSettingViewOpened))
    }
    
    var body: some View {

        VStack(spacing: 20)
        {
            headerSection
            
            Divider()
            
            HStack{
                Text("Show Network Summary in the Menu Bar")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Toggle(isOn: $showSummary) {}
                    .toggleStyle(.switch)
            }
            .frame(width: 350)
            
            HStack{
                Text("Display Animations")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Toggle(isOn: $useAnimations) {}
                    .toggleStyle(.switch)
            }
            .frame(width: 350)
            
            Divider()
        }
        .padding()
        .frame(width: 450)
        .background(Material.ultraThin)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(alignment: .topTrailing) {
            xCrossButton
        }
        
    }
    
    private let headerSection: HStack<TupleView<(Text, Spacer)>> = HStack {
        Text("Settings")
            .font(.largeTitle)
        
        Spacer()
    }
    
    private var xCrossButton: some View {
        Button {
            vm.isSettingViewOpened = false
        } label: {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .opacity(0.6)
                .padding()
        }
        .buttonStyle(.plain)
        .focusable(false)
    }
    
}

#Preview {
    SettingsView(isSettingViewOpened: .constant(false))
}
