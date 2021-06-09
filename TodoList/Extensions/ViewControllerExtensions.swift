//
//  ViewControllerExtensions.swift
//  TodoList
//
//  Created by Khalid Aqeeli on 09/06/2021.
//

import Foundation

extension ViewController: ItemViewModelDelegate {

    func didFinishUpdates(finished: Bool) {
        guard finished else {
            // Handle the unfinished state
            return
        }
        DispatchQueue.main.async {
            self.todoTableView.reloadData()
        }
    }
}
