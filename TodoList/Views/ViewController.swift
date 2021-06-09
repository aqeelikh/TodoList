//
//  ViewController.swift
//  TodoList
//
//  Created by Khalid Aqeeli on 08/06/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // To access itemTableViewModel
    let viewModel = ItemTableViewModel()
    
    @IBOutlet weak var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        configureViewController()
        setupUI()
    }
    
    func configureViewController() {

        todoTableView.delegate = self
        todoTableView.dataSource = self
        viewModel.delegate = self
        
        todoTableView.register(UINib(nibName: "TodoListItemTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoListItemTableViewCell")
        
        self.viewModel.getItems()
    }

    func setupUI(){
        title = "MVVM To Do List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self , action: #selector(didTapAdd))
    }
    
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: self.viewModel.addAlertTitle, message: self.viewModel.addAlertMessage, preferredStyle: .alert)
        
        //TODO: Imporve
        alert.addTextField(configurationHandler: nil)
        
        alert.addAction(UIAlertAction(title: self.viewModel.addActionTitle, style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text , !text.isEmpty else{
                return
            }
            self?.viewModel.addItem(note: text)
        }))
        present(alert, animated: true)
    }
    
    // UITAbleView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.todoListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoTableView.dequeueReusableCell(withIdentifier: "TodoListItemTableViewCell", for:  indexPath) as! TodoListItemTableViewCell
        cell.note?.text = self.viewModel.todoListArray[indexPath.row].note
        let item = self.viewModel.todoListArray[indexPath.row]
        cell.item = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todoTableView.deselectRow(at: indexPath, animated: true)

        let item = self.viewModel.todoListArray[indexPath.row]
        let sheet = UIAlertController(title: self.viewModel.sheetTitle, message: nil, preferredStyle: .actionSheet)
            
        sheet.addAction(UIAlertAction(title: self.viewModel.sheetCanelActionTitle, style: .cancel, handler:nil))
        
        sheet.addAction(UIAlertAction(title: self.viewModel.sheetEditActionTitle, style: .default, handler: {_ in
            
            let alert = UIAlertController(title: self.viewModel.alertTitle, message: self.viewModel.alertMessage, preferredStyle: .alert)
            // to show old message before editing
            alert.textFields?.first?.text = item.note
            //TODO: Imporve
            alert.addTextField(configurationHandler: nil)
            
            alert.addAction(UIAlertAction(title: self.viewModel.actionTitle, style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newItem = field.text , !newItem.isEmpty else{
                    return
                }
                self?.viewModel.updateItem(item: item, updatedNote: newItem)
            }))
            self.present(alert, animated: true)
        }))

        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.viewModel.deleteItem(item: item)
        }))
        present(sheet, animated: true)
    }
}
