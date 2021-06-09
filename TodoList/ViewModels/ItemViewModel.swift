//
//  ItemViewModel.swift
//  TodoListMVVM
//
//  Created by Khalid Aqeeli on 09/06/2021.
//

import Foundation
import UIKit
import SwiftUI

class ItemViewModel:ObservableObject {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @Published var items: [TodoListItem] = [] {
        didSet {
            do{
                try context.save()
            }
            catch{
                
            }
        }
    }
    
    let note: String
    let isSelected: Bool
    
    init(item: TodoListItem){
        self.note = item.note
        self.isSelected = item.completed
    }
    
    
    func getItems(){
        do {
            items = try context.fetch(TodoListItem.fetchRequest())
        }
        catch {
            //Handle error
        }
    }
    
    func addItem(note:String){
        
        let newItem = TodoListItem(context: context)
        newItem.completed = false
        // delete createdAT from view model
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
    
}


