//
//  ViewController.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 8.03.2021.
//

import UIKit
import Foundation


class ToDoListViewController: UIViewController{
    
    //MARK: Reference outlets! Days in a collection view and the tasks are in a table view.
    
    @IBOutlet weak var toDosTableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: ViewToPresenterProtocol?
    
    
    let alertDialogues = AlertDialogues.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter?.viewDidLoad()
        toDosTableView.delegate = self
        toDosTableView.dataSource = self
        
    }
    
    
}

extension ToDoListViewController {
    

    func setupUI(){
        overrideUserInterfaceStyle = .light
        self.title = "ToDo List"
        toDosTableView.register(UINib(nibName: "ToDoCell", bundle: nil), forCellReuseIdentifier: "ToDoCell")
        collectionView.register(UINib(nibName: "DayCell", bundle: nil), forCellWithReuseIdentifier: "DayCell")
        let rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addTapped)) //adds uibarbutton programatically
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func addTapped() {
        
        alertDialogues.showInputDialog(view: self) { (text) in
            guard let text = text else {return}
            self.presenter?.toDoAdded(detail: text)
            
        }
    }
    
}






extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.toDosCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = toDosTableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        
        cell.toDoItem = presenter?.toDo(indexPath: indexPath)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.toDoTapped(indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            presenter?.toDoDelete(indexPath: indexPath)
        }
    }
    
    
    
    
}

extension ToDoListViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.dayCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
        cell.day = presenter?.day(indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.dayTapped(indexPath:indexPath)
    }
    
    
    
}

extension ToDoListViewController: PresenterToViewProtocol {
    func showAlertMessage(message: String) {
        alertDialogues.showAlertDialog(view:self,message: message)
  
    }
    
    func reloadCollectionView() {
        hideActivityIndicator()
        
        self.collectionView.reloadData()
    }
    
    func onFetchCompleted() {
        hideActivityIndicator()
        
        self.toDosTableView.reloadData()
    }
    
    
    func showLoading() {
        showActivityIndicator()
        
    }
    
    
    func reloadData() {
        hideActivityIndicator()
        self.toDosTableView.reloadData()
    }
    
    fileprivate func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
    }
    fileprivate func showActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        self.view.isUserInteractionEnabled = false
    }
    
    
    
}


