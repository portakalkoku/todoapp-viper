//
//  ToDoListProtocol.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 9.03.2021.
//

import Foundation
//MARK: View -> Presenter
protocol ViewToPresenterProtocol:class {
    var view:PresenterToViewProtocol? {get set}
    var fragment:PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func viewDidLoad()
    func toDoTapped(indexPath:IndexPath)
    func toDoDelete(indexPath:IndexPath)
    func toDoAdded(detail:String)
    func dayTapped(indexPath:IndexPath)
    func toDosCount()->Int
    func toDo(indexPath:IndexPath)->ToDoItem?
    func dayCount() -> Int
    func day(indexPath:IndexPath) -> Day?
}
//MARK: Presenter -> View
protocol PresenterToViewProtocol :class{
    func showLoading()
    func reloadData()
    func showAlertMessage(message:String)
    func reloadCollectionView()

}
//MARK: Presenter -> Interactor
protocol  PresenterToInteractorProtocol :class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchToDos()
    func changeToDoCompletionStatus(uuid:UUID)
    func selectDay(index:Int)
    func deleteToDo(uuid:UUID)
    func addToDo(detail:String)
}
//MARK: Interactor->Presenter
protocol InteractorToPresenterProtocol:class {
    func fetchToDosSuccess(toDos:[ToDoItem])
    func fetchToDosFailure(error:String)
    func toDoProcessCompleted(toDos:[ToDoItem])
    func toDoProcessFailed()
    func deletionSuccessful()
    func daySelected(days:[Day])
    
}
//MARK:Presenter->Router
protocol PresenterToRouterProtocol :class{
    static func createModule() -> ToDoListViewController
}




