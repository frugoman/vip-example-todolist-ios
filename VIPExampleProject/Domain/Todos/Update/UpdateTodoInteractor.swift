//
//  TodoDetailInteractor.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 17/11/2020.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

protocol UpdateTodoInteractorInput {

    func update(todo: TodoItem)
}

protocol UpdateTodoInteractorOutput {
    
    func didUpdate(todo: TodoItem)
    
    func errorUpdatingTodo(_ todo: TodoItem, error: Error)
}

class UpdateTodoInteractor: UpdateTodoInteractorInput {
    
    private let datasource: TodosDataSource
    private let output: UpdateTodoInteractorOutput
    
    init(datasource: TodosDataSource, output: UpdateTodoInteractorOutput) {
        self.datasource = datasource
        self.output = output
    }
    
    func update(todo: TodoItem) {
        datasource.update(todo: todo) { result in
            switch result {
            case let .success(todo):
                output.didUpdate(todo: todo)
            case let .failure(error):
                output.errorUpdatingTodo(todo, error: error)
            }
        }
    }
}
