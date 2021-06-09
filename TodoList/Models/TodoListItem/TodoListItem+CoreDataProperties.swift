//
//  TodoListItem+CoreDataProperties.swift
//  TodoListMVVM
//
//  Created by Khalid Aqeeli on 08/06/2021.
//
//

import Foundation
import CoreData


extension TodoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoListItem> {
        return NSFetchRequest<TodoListItem>(entityName: "TodoListItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var createdAt: Date?
    @NSManaged public var note: String
    @NSManaged public var isCompleted: Bool

}

extension TodoListItem : Identifiable {

}
