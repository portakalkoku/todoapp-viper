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
    
    func addToDoToJson(toDoItem:ToDoItem,completion: @escaping (Bool) -> Void) {
        guard var toDoList = readJsonFile() else {return}
        
        toDoList.append(toDoItem)
        saveToJsonFile(toDoList: toDoList) { (success) in
            completion(success)
        }

    }
    
    
    //Dummy data if there is no todos.json file on the directory! We want to see some data on the first launch!
    let _dummyDatas = [ToDoItem(detail: "Go outside with the dog", completed: false, uuid: UUID(), belongTo: 1),
                       ToDoItem(detail: "Go outside with the dog", completed: false, uuid: UUID(), belongTo: 2),
                       ToDoItem(detail: "Go outside with the dog", completed: false, uuid: UUID(), belongTo: 3),
                       ToDoItem(detail: "Go outside with the dog", completed: false, uuid: UUID(), belongTo: 4),
                       ToDoItem(detail: "Go outside with the dog", completed: false, uuid: UUID(), belongTo: 5),
                       ToDoItem(detail: "Go outside with the dog", completed: false, uuid: UUID(), belongTo: 6),
                       ToDoItem(detail: "Go outside with the dog", completed: false, uuid: UUID(), belongTo: 7),
                       ToDoItem(detail: "Go shopping", completed: false, uuid: UUID(), belongTo: 2),
                       ToDoItem(detail: "Play video game", completed: false, uuid: UUID(), belongTo: 4),
                       ToDoItem(detail: "Watch a movie", completed: false, uuid: UUID(), belongTo: 3),
                       ToDoItem(detail: "Don't forget to drink 5 liters of water", completed: false, uuid: UUID(), belongTo: 6),
                       ToDoItem(detail: "You have Cambly reservation tonight", completed: false, uuid: UUID(), belongTo: 1),
                       ToDoItem(detail: "New episode of TWD", completed: false, uuid: UUID(), belongTo: 1),
                       ToDoItem(detail: "Check your personal mail", completed: false, uuid: UUID(), belongTo: 2),
                       ToDoItem(detail: "Phone a friend", completed: false, uuid: UUID(), belongTo: 4),
                       ToDoItem(detail: "Sleep at least 6 hours", completed: false, uuid: UUID(), belongTo: 3),
                       ToDoItem(detail: "Spend sometime on Medium", completed: false, uuid: UUID(), belongTo: 6),
                       ToDoItem(detail: "Dont forget to update your Linkedin Profile", completed: false, uuid: UUID(), belongTo: 4),
                       ToDoItem(detail: "Watch a movie", completed: false, uuid: UUID(), belongTo:5),
                       ToDoItem(detail: "Don't forget to drink 5 liters of water", completed: false, uuid: UUID(), belongTo: 7),
                       ToDoItem(detail: "You have Cambly reservation tonight", completed: false, uuid: UUID(), belongTo: 5),
                       ToDoItem(detail: "New episode of TWD", completed: false, uuid: UUID(), belongTo: 5),
                       ToDoItem(detail: "Check your personal mail", completed: false, uuid: UUID(), belongTo: 6),
                       ToDoItem(detail: "Phone a friend", completed: false, uuid: UUID(), belongTo: 4),
                       ToDoItem(detail: "Sleep at least 6 hours", completed: false, uuid: UUID(), belongTo: 3),
                       ToDoItem(detail: "Spend sometime on Medium", completed: false, uuid: UUID(), belongTo: 2),
                       ToDoItem(detail: "Dont forget to update your Linkedin Profile", completed: false, uuid: UUID(), belongTo: 1),]
    
    
    
}

