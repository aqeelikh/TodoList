//
//  ViewController.swift
//  TodoListMVVM
//
//  Created by Khalid Aqeeli on 08/06/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var todoListArray = [TodoListItem]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        todoTableView.delegate = self
        todoTableView.dataSource = self
        todoTableView.register(UINib(nibName: "TodoListItemTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoListItemTableViewCell")
        setupUI()
        getItems()
    }
    
    // UITAbleView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoTableView.dequeueReusableCell(withIdentifier: "TodoListItemTableViewCell", for:  indexPath) as! TodoListItemTableViewCell
        cell.note?.text = todoListArray[indexPath.row].note
        let item = todoListArray[indexPath.row]
        cell.item = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todoTableView.deselectRow(at: indexPath, animated: true)

        let item = todoListArray[indexPath.row]
        let sheet = UIAlertController(title: "Edit Note", message: nil, preferredStyle: .actionSheet)
    
        //TODO: Imporve add memomry leak handlers
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: {_ in
            
            let alert = UIAlertController(title: "Edit Note", message: "Edit your Note", preferredStyle: .alert)
            // to show old message before editing
            alert.textFields?.first?.text = item.note
            //TODO: Imporve
            alert.addTextField(configurationHandler: nil)
            
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newItem = field.text , !newItem.isEmpty else{
                    return
                }
                self?.updateItem(item: item, updatedNote: newItem)
            }))
            self.present(alert, animated: true)
        }))

        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        present(sheet, animated: true)
    }
    
    //CoreDate
    
    func getItems(){
        do {
            todoListArray = try context.fetch(TodoListItem.fetchRequest())
            DispatchQueue.main.async {
                self.todoTableView.reloadData()
            }
        }
        catch {
            //Handle error
        }
    }
    
    func addItem(note:String){
        
        let newItem = TodoListItem(context: context)
        newItem.isCompleted = false
        newItem.createdAt = Date()
        newItem.note = note
        
        do {
            try context.save()
            getItems()
        }
        catch {
            //Handle error
        }
    }
    
    func deleteItem(item:TodoListItem){
        context.delete(item)

        do {
            try context.save()
            getItems()
        }
        catch {
            //Handle error
        }
    }
    
    func updateItem(item:TodoListItem, updatedNote:String){
        item.note = updatedNote
        
        do {
            try context.save()
            getItems()
        }
        catch {
            //Handle error
        }
    }
    
    
    func setupUI(){
        title = "MVVM To Do List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self , action: #selector(didTapAdd))
    }
    
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: "New Note", message: "Enter new Note", preferredStyle: .alert)
        
        //TODO: Imporve
        alert.addTextField(configurationHandler: nil)
        
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text , !text.isEmpty else{
                return
            }
            self?.addItem(note: text)
        }))
        present(alert, animated: true)
    }
}
