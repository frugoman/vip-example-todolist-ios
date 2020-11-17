//
//  AddTodoInteractor.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 10/1/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import Foundation

protocol AddTodoInteractorInput {
    
    func add(todoWithTitle title: String)
}

protocol AddTodoInteractorOutput {
    
    func didCreate(todo: TodoItem)
    
    func errorCreatingTodos(_ error: Error)
}

class AddTodoInteractor: AddTodoInteractorInput {
    
    private let dataSource: TodosDataSource
    private let output: AddTodoInteractorOutput
    
    init(dataSource: TodosDataSource, output: AddTodoInteractorOutput) {
        self.dataSource = dataSource
        self.output = output
    }
    
    func add(todoWithTitle title: String) {
        let item = TodoItem(title: title)
        dataSource.add(todoItem: item) { (result) in
            switch result {
            case let .success(todoItem):
                output.didCreate(todo: todoItem)
            case let .failure(error):
                output.errorCreatingTodos(error)
            }
        }
    }
}
