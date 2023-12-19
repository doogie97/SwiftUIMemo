//
//  SwiftUIMemoApp.swift
//  SwiftUIMemo
//
//  Created by Doogie on 12/19/23.
//

import SwiftUI

@main
struct SwiftUIMemoApp: App {
    @StateObject var store = MemoStore()
    let coredataManager = CoredataManager.shared

    var body: some Scene {
        WindowGroup {
            MainListView()
                .environment(\.managedObjectContext, coredataManager.container.viewContext)
                .environmentObject(store)
        }
    }
}
