//
//  CoredataManager.swift
//  SwiftUIMemo
//
//  Created by Doogie on 12/19/23.
//

import CoreData

class CoredataManager: ObservableObject {
    static let shared = CoredataManager()
    
    let container: NSPersistentContainer
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SwiftUIMemo")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveContenxt() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch let error {
                print(error)
            }
        }
    }
    
    func addMemo(content: String) {
        let newMemo = MemoEntity(context: mainContext)
        newMemo.content = content
        newMemo.insertDate = Date.now
        
        saveContenxt()
    }
    
    func update(memo: MemoEntity?, content: String) {
        memo?.content = content
        saveContenxt()
    }
    
    func delete(memo: MemoEntity?) {
        if let memo = memo {
            mainContext.delete(memo)
            saveContenxt()
        }
    }
}
