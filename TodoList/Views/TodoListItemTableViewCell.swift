//
//  TodoListItemTableViewCell.swift
//  TodoList
//
//  Created by Khalid Aqeeli on 08/06/2021.
//

import UIKit

class TodoListItemTableViewCell: UITableViewCell {

    var flag = false

    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var btnFlag: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var item : TodoListItem! {
        didSet {
            btnFlag.isSelected = item.isCompleted
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func taskComplated(_ sender: UIButton){
        
        self.btnFlag.isSelected = !flag
        flag = !flag
        
        let selected = !sender.isSelected
        sender.isSelected = selected
        item.isCompleted = selected
        
        do {
            try context.save()
        }
        catch {
            //Handle error
        }
    }
    
}
