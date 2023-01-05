//
//  AppStorageManager.swift
//  NoteSwiftUI
//
//  Created by Александр Платонов on 03.01.2023.
//

import SwiftUI

class AppStorageManager {

    static let shared = AppStorageManager()

    @AppStorage("isFirstLaunchApp") private var isFirstLaunchApp: Bool = true

    private init() {}

    func saveStatusFirstLaunchApp(isFirstLaunchApp: Bool) {
        self.isFirstLaunchApp = isFirstLaunchApp
    }

    func loadStatusFirstLaunchApp() -> Bool {
        isFirstLaunchApp
    }
}

