//
//  CoreDataManager.swift
//  NoteSwiftUI
//
//  Created by Александр Платонов on 26.12.2022.
//

import CoreData

class CoreDataManager: ObservableObject {
       
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "NoteSwiftUI")
        loadPersistentStores()
    }
    
    
    func loadPersistentStores() {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                print("ERROR loading Core Data: \(error!.localizedDescription)")
                return
            }
        }
    }
    
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("An ERROR occurred while save: \(error.localizedDescription)")
            }
        }
    }
    
    private func sortFetchNotes() -> [NSSortDescriptor] {
        let dataSort = NSSortDescriptor(keyPath: \Note.timestamp, ascending: false)
        return [dataSort]
    }
    
    func fetchData() -> [Note] {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.sortDescriptors = sortFetchNotes()
        
        var notes: [Note] = []
        do {
            notes = try viewContext.fetch(request)
        } catch let error {
            print("Error load fetchTask: \(error.localizedDescription)")
        }
        return notes
    }
    

    func deleteAllData() {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            let allNotes = try viewContext.fetch(request)
            for note in allNotes {
                viewContext.delete(note)
            }
        } catch let error {
            print("Error load fetchTask: \(error.localizedDescription)")
        }
        save()
    }
}
