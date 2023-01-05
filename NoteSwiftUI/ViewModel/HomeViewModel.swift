//
//  HomeViewModel.swift
//  NoteSwiftUI
//
//  Created by Александр Платонов on 28.12.2022.
//

import Foundation


class HomeViewModel: ObservableObject {
    
    private var coreDataManager = CoreDataManager.shared
    
    @Published var notes: [Note] = []
    @Published var isNewNote: Bool = false
    private var isFirstLaunchApp: Bool
    
    init() {
        isFirstLaunchApp = AppStorageManager.shared.loadStatusFirstLaunchApp()
        if isFirstLaunchApp {
            defaultListNotes()
            isFirstLaunchApp.toggle()
            AppStorageManager.shared.saveStatusFirstLaunchApp(isFirstLaunchApp: isFirstLaunchApp)
            coreDataManager.save()
        } else {
            updateData()
        }
    }
    
    func addNote() {
        isNewNote.toggle()
    }
    
    
    func updateData() {
        notes = coreDataManager.fetchData()
    }
    
    
    func deleteNote(note: Note) {
        coreDataManager.viewContext.delete(note)
        coreDataManager.save()
        updateData()
    }
    
    func defaultListNotes() {
        let defaultNote = Note(context: coreDataManager.viewContext)
        defaultNote.content = "This is the first note. Swipe to remove it. Let's add a new."
        defaultNote.timestamp = Date()
        defaultNote.title = "First note"
        notes = [defaultNote]
    }
}
        
