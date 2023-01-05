//
//  NoteSwiftUIApp.swift
//  NoteSwiftUI
//
//  Created by Александр Платонов on 26.12.2022.
//

import SwiftUI

@main
struct NoteSwiftUIApp: App {
    @StateObject var viewModel = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
                .preferredColorScheme(.dark)
        }
    }
}
