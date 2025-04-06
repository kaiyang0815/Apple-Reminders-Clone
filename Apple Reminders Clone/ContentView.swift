//
// ContentView.swift
// Apple Reminders Clone
//
// Copyright © 2025 Kaiyang0815.
// All Rights Reserved.

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    @State private var searchText: String = ""

    @ViewBuilder func PinnedNav(
        icon: String,
        title: String,
        count: Int?,
        edge: Edge.Set = .horizontal,
        color: Color
    ) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.background)
                .frame(height: 80)

            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Circle()
                            .fill(color)
                            .frame(width: 30, height: 30)
                            .overlay {
                                Image(systemName: icon)
                                    .foregroundStyle(.white)
                            }
                        Text(title)
                            .font(.subheadline)
                            .bold()
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    if let count {
                        Text(count, format: .number)
                            .font(.title)
                            .bold()
                    }
                }
            }
            .padding()
        }
        .padding(edge, 6)
    }

    var body: some View {
        NavigationSplitView {
            List {
                Section {
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 12) {
                        PinnedNav(
                            icon: "calendar",
                            title: "Today",
                            count: 2,
                            edge: .trailing,
                            color: .blue
                        )
                        PinnedNav(
                            icon: "calendar",
                            title: "Scheduled",
                            count: 32,
                            edge: .leading,
                            color: .red
                        )
                        PinnedNav(
                            icon: "tray.fill",
                            title: "All",
                            count: 122,
                            edge: .trailing,
                            color: .black
                        )
                        PinnedNav(
                            icon: "flag.fill",
                            title: "Flagged",
                            count: 0,
                            edge: .leading,
                            color: .orange
                        )
                        PinnedNav(
                            icon: "checkmark",
                            title: "Completed",
                            count: nil,
                            edge: .trailing,
                            color: .secondary
                        )
                    }
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                Section {
                    
                } header: {
                    Text("My Lists")
                        .bold()
                        .font(.headline)
                        .foregroundStyle(.black)
                }
                .textCase(nil)
                .listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 10, trailing: 0))
            }
            .listStyle(.insetGrouped)
            #if os(macOS)
                .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            #endif
            .toolbar {
                ToolbarItemGroup(placement: .secondaryAction) {
                    Button {

                    } label: {
                        Label("Edit Lists", systemImage: "pencil")
                    }
                    Button {

                    } label: {
                        Label("Template", systemImage: "square.on.square")
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        Button {

                        } label: {
                            Image(systemName: "plus.circle.fill")
                            Text("New Reminder")
                                .bold()
                        }
                        Spacer()
                        Button {

                        } label: {
                            Text("Add List")
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .searchDictationBehavior(.inline(activation: .onLook))
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
