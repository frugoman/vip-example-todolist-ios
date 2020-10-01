//
//  AddTodoViewController.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 10/1/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import UIKit

class AddTodoViewController: UIAlertController {
    
    private var interactor: AddTodoInteractorInput!
    
    convenience init(interactor: AddTodoInteractorInput) {
        self.init(title: "Add Todo", message: nil, preferredStyle: .alert)
        self.interactor = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTextField(configurationHandler: nil)
        addAction(.init(title: "Add", style: .default, handler: { [interactor, textFields] (_) in
            guard let todoTitle = textFields!.first!.text, !todoTitle.isEmpty else {
                return
            }
            
            interactor?.add(todo: TodoItem(title: todoTitle))
            }))
        addAction(.init(title: "Cancel", style: .cancel, handler: { [interactor] (_) in
             interactor?.cancel()
        }))
    }
}
