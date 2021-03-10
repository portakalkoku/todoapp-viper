//
//  ViewController.swift
//  todoapp
//
//  Created by Çağrı Portakalkökü on 8.03.2021.
//

import UIKit
import Foundation


class ToDoListViewController: UIViewController{
    
    @IBOutlet weak var toDosTableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupUI()
        presenter?.viewDidLoad()
        toDosTableView.delegate = self
        toDosTableView.dataSource = self
     
    }
      
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    var presenter: ViewToPresenterProtocol?

}

extension ToDoListViewController {
    
    func setupUI(){
        overrideUserInterfaceStyle = .light
        self.title = "ToDo List"
        toDosTableView.register(UINib(nibName: "ToDoCell", bundle: nil), forCellReuseIdentifier: "ToDoCell")
        
        collectionView.register(UINib(nibName: "DayCell", bundle: nil), forCellWithReuseIdentifier: "DayCell")
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
        presenter?.taskTapped(indexPath: indexPath)
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

        let alertDialog = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alertDialog.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertDialog, animated: true, completion: nil)
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
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        self.view.isUserInteractionEnabled = false
        
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
    
    
    
}


