//
//  ToDosInteractor.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 8.03.2021.
//

import Foundation
class ToDoListInteractor: PresenterToInteractorProtocol {
   

    
    
    var toDoList:[ToDoItem]?
    let dayManager = DayManager.shared
    var days = DayManager.shared.dayList
    var selectedDay:Day?
    let documentManager = DocumentManager.shared
    
    weak var presenter: InteractorToPresenterProtocol?
    

    
    func selectDay(index: Int) {
        
        var day = days[index]
        day.selected = true
        deselectOtherDays()
        
        days[index] = day
        selectedDay = day
        
        presenter?.daySelected(days: days)
        fetchToDos()
    }
    
    
    func deselectOtherDays() {
        for i in 0...days.count - 1 {
            days[i].selected = false
        }
    }
    
    func deleteToDo(uuid: UUID) {
        guard var toDoList = self.toDoList else {
            return
        }
        let indexOfSelectedToDo = toDoList.firstIndex(where: { (item) -> Bool in
            item.uuid == uuid
        })
        
        guard let index = indexOfSelectedToDo else {
            return
        }
        
        documentManager.removeToDoFromJson(uuid: uuid) { (success) in
            if(success) {
                toDoList.remove(at: index)
                self.toDoList = toDoList
                self.presenter?.statusChangedSuccessfully(toDos: self.toDoList ?? [])
            }else {
                self.presenter?.statusChangedFailure()
            }
        }
    
     
        
        
    }
    

 
    
    func changeToDoCompletionStatus(uuid:UUID) {
        guard var toDoList = self.toDoList else {
            return
        }
        let indexOfSelectedToDo = toDoList.firstIndex(where: { (item) -> Bool in
            item.uuid == uuid
        })
        
        guard let index = indexOfSelectedToDo else {
            return
        }
        
        var toDo = toDoList[index]
        changeToDoStatus(&toDo, &toDoList, index)
        documentManager.updateJsonFile(toDoItem: toDo) { (success) in
            if(success) {
                self.presenter?.statusChangedSuccessfully(toDos: self.toDoList ?? [])
            }
            else {
                var toDo = toDoList[index]
                self.changeToDoStatus(&toDo, &toDoList, index)
                self.presenter?.statusChangedFailure()
                
            }
        }
        
    }
    

    
    func fetchToDos() {
        guard let selectedDay = self.selectedDay else {return}
        
        toDoList = ToDoManager.shared.fetchToDos().filter({ (toDoItem) -> Bool in
            toDoItem.belongTo == selectedDay.id
        })
        presenter?.fetchToDosSuccess(toDos: toDoList ?? [])
    }
    
    fileprivate func changeToDoStatus(_ toDo: inout ToDoItem, _ toDoList: inout [ToDoItem], _ index: Array<ToDoItem>.Index) {
        toDo.completed = !toDo.completed
        toDoList[index] = toDo
        self.toDoList = toDoList
    }
}
