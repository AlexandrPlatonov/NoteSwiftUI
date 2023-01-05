//
//  NoteNewAndEditViewModel.swift
//  NoteSwiftUI
//
//  Created by Александр Платонов on 26.12.2022.
//

import Foundation

class NoteNewAndEditViewModel: ObservableObject {
        
    @Published var newContent: String = ""
    @Published var editContent: String
    @Published var note: Note?
    @Published var isNewNote: Bool
    @Published var titleNote: String
    
    private var coreDataManager = CoreDataManager.shared
    
    
    init(note: Note? = nil, isNewNote: Bool) {
        self.editContent = note?.content ?? ""
        self.note = note
        self.isNewNote = isNewNote
        
        if note == nil {
            self.titleNote = ""
        } else {
            self.titleNote = note!.title!
        }
    }


    func addNote(homeViewModel: HomeViewModel) {
        if !newContent.isEmpty {
            let newNote = Note(context: coreDataManager.viewContext)
            newNote.content = newContent
            newNote.timestamp = Date()
            newNote.title = titleNote
            coreDataManager.save()
            homeViewModel.notes = coreDataManager.fetchData()
        }
    }


    func updateNote(homeViewModel: HomeViewModel) {
        if editContent != note?.content || titleNote != note?.title {
            note?.content = editContent
            note?.timestamp = Date()
            note?.title = titleNote
            coreDataManager.save()
            homeViewModel.notes = coreDataManager.fetchData()
        }
    }
    
    
    func changeButtonBackText() -> Bool {
        if editContent == note?.content && titleNote == note?.title {
            return true
        } else {
            return false
        }
        
    }
}
