//
//  File.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 8.03.2021.
//

import Foundation
class ToDoListPresenter: ViewToPresenterProtocol {



    var fragment: PresenterToViewProtocol?
    var router: PresenterToRouterProtocol?
    weak var view: PresenterToViewProtocol?
    var interactor:PresenterToInteractorProtocol?
    
    var  toDoList:[ToDoItem]?
    var dayList:[Day]?
    
    
    
    func dayCount() -> Int {
        guard let days = dayList else {
            return 0
        }
        
        return days.count
    }
    
    func toDoAdded(detail: String) {
        view?.showLoading()
        interactor?.addToDo(detail: detail)
        
    }
    

    
    func day(indexPath: IndexPath) -> Day? {
        guard let days = dayList else {
            return nil
        }
        
        return days[indexPath.row]
    }
    
    func toDoDelete(indexPath: IndexPath) {
        guard let  toDoList = self.toDoList else {
            return
        }
        interactor?.deleteToDo(uuid: toDoList[indexPath.row].uuid)
        
    }
    
    
    func toDosCount() -> Int{
        guard let  toDoList = self.toDoList else {
            return 0
        }
        return toDoList.count
        
    }
    
    func toDo(indexPath:IndexPath) -> ToDoItem? {
        
        guard let toDoList = self.toDoList else {
            return nil
        }
        return toDoList[indexPath.row]
    }
    
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.fetchToDos()
        interactor?.selectDay(index: 0)
        
    }
    
    
    func toDoTapped(indexPath:IndexPath) {
        guard let  toDoList = self.toDoList else {
            return
        }
        interactor?.changeToDoCompletionStatus(uuid: toDoList[indexPath.row].uuid)
    
        
    }
    
    func dayTapped(indexPath:IndexPath) {
        
        interactor?.selectDay(index: indexPath.row)
    }

}

extension ToDoListPresenter:InteractorToPresenterProtocol {
    func deletionSuccessful() {
        
    }
    
    func toDoProcessFailed() {
        view?.showAlertMessage(message: "Status of the todo couldn't be changed")
    }
    
    func daySelected(days: [Day]) {
        self.dayList = days
        view?.reloadCollectionView()
    }
    
    func fetchDaysSuccess(days: [Day]) {
        self.dayList = days
        view?.reloadCollectionView()
    }
    
    func toDoProcessCompleted(toDos: [ToDoItem]) {
        self.toDoList = toDos
        view?.reloadData()
    }
    
    func completeStatusChanged() {
        view?.reloadData()
    }
    
    func fetchToDosSuccess(toDos: [ToDoItem]) {
        self.toDoList = toDos
        view?.reloadData()
    }
    
    func fetchToDosFailure(error: String) {
        view?.showAlertMessage(message: error)
        
    }
    
    
}
