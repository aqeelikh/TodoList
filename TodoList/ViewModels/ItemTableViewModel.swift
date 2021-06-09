//
//  ItemTableViewModel.swift
//  TodoList
//
//  Created by Khalid Aqeeli on 09/06/2021.
//

import Foundation
import UIKit

class ItemTableViewModel {

    var delegate: ItemViewModelDelegate?
    
    var sheetTitle = "Edit Note"
    var sheetCanelActionTitle = "Cancel"
    var sheetEditActionTitle = "Edit"
    
    var alertTitle = "Update Note"
    var alertMessage = "Edit your Note"
    var actionTitle = "Save"
    
    var addAlertTitle = "New Note"
    var addAlertMessage = "Enter new Note"
    var addActionTitle = "Submit"

    var todoListArray = [TodoListItem]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func getItems(){
        do {
            todoListArray = try context.fetch(TodoListItem.fetchRequest())
            self.delegate?.didFinishUpdates(finished: true)
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
            // Handle error
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

}
