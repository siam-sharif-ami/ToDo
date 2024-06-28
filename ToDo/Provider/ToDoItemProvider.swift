//
//  ToDoItemProvider.swift
//  ToDo
//
//  Created by BS00484 on 28/6/24.
//

import Foundation
import CoreData

final class ToDoItemProvider {
    
    static let shared = ToDoItemProvider()
    
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    /// this is just to temporarily save into memory
    var newContext: NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
    
    private init(){
        
        /// this is the name of the xcdatamodel file
        persistentContainer = NSPersistentContainer(name: "ToDo")
        
        /// whenever a change happens in context, it automatically get saved
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        
        persistentContainer.loadPersistentStores {_, error in
            if let error {
                fatalError("Unable to load store with error: \(error)")
            }
        }
    }
}
