//
// Apple_Reminders_CloneApp.swift
// Apple Reminders Clone
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.


import SwiftUI
import SwiftData

@main
struct Apple_Reminders_CloneApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
