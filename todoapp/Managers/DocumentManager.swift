//
//  DocumentManager.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 10.03.2021.
//

import Foundation
class DocumentManager {
    static let shared = DocumentManager()
    
    func readJsonFile() -> [ToDoItem]?{
        
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        let fileUrl = documentsDirectoryUrl.appendingPathComponent("todos.json")
        print(fileUrl)
        
        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            guard let toDoList = try JSONDecoder().decode([ToDoItem]?.self, from: data) else { return nil }
            return toDoList
        } catch {
            // json file does not created yet. Used dummy datas to create json file! Because it is desired to see some todos in the first launching of the app!
            saveToJsonFile(toDoList: _dummyDatas, completion: nil)
            return _dummyDatas
            
        }
    }
    
    func saveToJsonFile(toDoList:[ToDoItem],completion:( (Bool) -> Void)?) {
        // Get the url of Persons.json in document directory
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("todos.json")
        
        // Transform array into data and save it into file
        do {
            let data = try JSONEncoder().encode(toDoList)
            try data.write(to: fileUrl, options: [])
            
            guard  let completion = completion  else {
                return
            }
            completion(true)
        } catch {
            guard  let completion = completion  else {
                return
            }
            completion(false)
        }
    }
    
    func updateJsonFile(toDoItem:ToDoItem,completion: @escaping (Bool) -> Void) {
        guard var toDoList = readJsonFile() else {return}
        let indexOfToDo = toDoList.firstIndex { (td) -> Bool in
            td.uuid == toDoItem.uuid
        }
        guard let index = indexOfToDo else {
            completion(false)
            return
        }
        toDoList[index] = toDoItem
        saveToJsonFile(toDoList: toDoList) { (success) in
            completion(success)
        }
    }
    
    
    func removeToDoFromJson(uuid:UUID,completion: @escaping (Bool) -> Void) {
        guard var toDoList = readJsonFile() else {return}
        
        toDoList.removeAll { (toDo) -> Bool in
            toDo.uuid == uuid
        }
        saveToJsonFile(toDoList: toDoList) { (success) in
            completion(success)
        }

    }
    
    let _dummyDatas = [ToDoItem(detail: "Köpek dışarı çıkarılacak.", completed: false, uuid: UUID(), belongTo: 1),
                       ToDoItem(detail: "Market alışverişi yapılacak", completed: false, uuid: UUID(), belongTo: 2),
                       ToDoItem(detail: "Ders çalış", completed: false, uuid: UUID(), belongTo: 4),
                       ToDoItem(detail: "Oyun oyna", completed: false, uuid: UUID(), belongTo: 3),
                       ToDoItem(detail: "Köpeği dışarı çıkar", completed: false, uuid: UUID(), belongTo: 6),
                       ToDoItem(detail: "Köpeği dışarı çıkar.", completed: false, uuid: UUID(), belongTo: 1),
                       ToDoItem(detail: "Köpek dışarı çıkarılacak.", completed: false, uuid: UUID(), belongTo: 1),
                       ToDoItem(detail: "Market alışverişi yapılacak", completed: false, uuid: UUID(), belongTo: 2),
                       ToDoItem(detail: "Ders çalış", completed: false, uuid: UUID(), belongTo: 4),
                       ToDoItem(detail: "Oyun oyna", completed: false, uuid: UUID(), belongTo: 3),
                       ToDoItem(detail: "Köpeği dışarı çıkar", completed: false, uuid: UUID(), belongTo: 6),
                       ToDoItem(detail: "Köpeği dışarı çıkar.", completed: false, uuid: UUID(), belongTo: 1),
                       ToDoItem(detail: "Köpek dışarı çıkarılacak.", completed: false, uuid: UUID(), belongTo: 1),
                       ToDoItem(detail: "Market alışverişi yapılacak", completed: false, uuid: UUID(), belongTo: 2),
                       ToDoItem(detail: "Ders çalış", completed: false, uuid: UUID(), belongTo: 4),
                       ToDoItem(detail: "Oyun oyna", completed: false, uuid: UUID(), belongTo: 3),
                       ToDoItem(detail: "Köpeği dışarı çıkar", completed: false, uuid: UUID(), belongTo: 6),
                       ToDoItem(detail: "Köpeği dışarı çıkar.", completed: false, uuid: UUID(), belongTo: 1),]
    
    
    
}

