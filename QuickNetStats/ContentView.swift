//
//  ContentView.swift
//  QuickNetStats
//
//  Created by Federico Imberti on 2025-11-07.
//

import SwiftUI
import AppKit

struct ContentView: View {
    
    @StateObject var netStats:NetworkStatsManager = NetworkStatsManager()
    @StateObject var netDetails:NetworkDetailsManager = NetworkDetailsManager()
    
    var linkQualityColor: Color {
        switch netStats.netStats.linkQuality {
        case .good:
            return Color.green
        case .moderate:
            return Color.orange
        case .minimal:
            return Color.red
        default:
            return Color.secondary
        }
    }
    
        
    var body: some View {
        VStack(spacing: 16) {
            HStack (alignment: .center, spacing: 40){
                NetworkInterfaceView(
                    netIntervaceType: netStats.netStats.interfaceType,
                    isAvailable: netStats.netStats.isConnected,
                    linkQualityColor: linkQualityColor
                )
                LinkQualityView(
                    linkQuality: netStats.netStats.linkQuality,
                    linkQualityColor: linkQualityColor
                )
            }
            
            ipButtonsSection

            exceptionDescriptionSection
            
            Divider()
            
            footerButtonsSection
            
        }
        .padding()
        .task {
            netStats.startMonitoring()
            await netDetails.getAddresses()
        }
    }
    
    var exceptionDescriptionSection: some View {
        return Group {
            if netStats.netStats.isExpensive || netStats.netStats.isConstrained {
                Divider()
                
                if netStats.netStats.isExpensive {
                    Text("You are connected to a cellular connection which may have a network cap")
                        .foregroundStyle(.secondary)
                }
                
                if netStats.netStats.isConstrained {
                    Text("Low Data Mode is anabled for this network")
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
    
    var footerButtonsSection: some View {
        return HStack(spacing: 40) {
            Button {
                exit(0)
            } label: {
                FooterButtonLabelView(labelText: "Quit", systemName: "power")
            }
            
            Button {
                Task {
                    netStats.refresh()
                    await netDetails.getAddresses()
                }
            } label: {
                FooterButtonLabelView(labelText: "Refresh", systemName: "arrow.trianglehead.counterclockwise")
            }
            
            Button {
                
            } label: {
                FooterButtonLabelView(labelText: "Settings", systemName: "gear")
            }

        }
        .buttonStyle(.plain)

    }
    
    var ipButtonsSection: some View {
        HStack(spacing: 16) {
            Button {
                if let publicIP = netDetails.publicIP {
                    copyToClipboard(publicIP)
                }
            } label: {
                AddressView(title: "Public IP", value: netDetails.publicIP ?? "Unavailbable")
            }
            .help("Click to copy to Clipboard")
            
            Button {
                if let privateIP = netDetails.privateIP {
                    copyToClipboard(privateIP)
                }
            } label: {
                AddressView(title: "Private IP", value: netDetails.privateIP ?? "Unavailbable")
            }
            .help("Click to copy to Clipboard")
        }
        .buttonStyle(.plain)
    }
}

func copyToClipboard(_ str :String) {
    let pasteboard = NSPasteboard.general
    pasteboard.clearContents()
    pasteboard.setString(str, forType: .string)
}

#Preview {
    ContentView()
}

//#Preview("Good Connection") {
//    ContentView(
//        netStats: NetworkStatsManager(netStats: NetworkStats.mockGoodWifiCoonection),
//        netDetails: NetworkDetailsManager(privateIP: "10.0.0.32", publicIP: "100.10.30.2")
//    )
//        .padding()
//        .frame(width: 550)
//}
//
//#Preview("Moderate Connection") {
//    ContentView(
//        netStats: NetworkStatsManager(netStats: NetworkStats.mockModerateWifiCoonection),
//        netDetails: NetworkDetailsManager(privateIP: "10.0.0.32", publicIP: "100.10.30.2")
//    )
//    .padding()
//    .frame(width: 550)
//}
//
//#Preview("Constrained") {
//    ContentView(
//        netStats: NetworkStatsManager(netStats: NetworkStats.mockConstrainedWifiCoonection),
//        netDetails: NetworkDetailsManager(privateIP: "10.0.0.32", publicIP: "100.10.30.2")
//    )
//    .padding()
//    .frame(width: 550)
//}
//
//#Preview("Constriied + Expansive") {
//    ContentView(
//        netStats: NetworkStatsManager(netStats: NetworkStats.mockConstrainedAndExpansiveWifiCoonection),
//        netDetails: NetworkDetailsManager(privateIP: "10.0.0.32", publicIP: "100.10.30.2")
//    )
//    .padding()
//    .frame(width: 550)
//}
//
//
//#Preview("Disconnected") {
//    ContentView(
//        netStats: NetworkStatsManager(netStats: NetworkStats.mockDisconnected),
//        netDetails: NetworkDetailsManager()
//    )
//    .padding()
//    .frame(width: 550)
//}
