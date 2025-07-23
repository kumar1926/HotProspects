//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by BizMagnets on 22/07/25.
//

import SwiftUI
import SwiftData
@main
struct HotProspectsApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
