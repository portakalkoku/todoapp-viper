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
    func taskTapped(indexPath:IndexPath)
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
}
//MARK: Interactor->Presenter
protocol InteractorToPresenterProtocol:class {
    func fetchToDosSuccess(toDos:[ToDoItem])
    func fetchToDosFailure(error:String)
    func statusChangedSuccessfully(toDos:[ToDoItem])
    func statusChangedFailure()
    func daySelected(days:[Day])
    
}
//MARK:Presenter->Router
protocol PresenterToRouterProtocol :class{
    static func createModule() -> ToDoListViewController
}




