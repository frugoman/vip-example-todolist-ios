//
//  GetTodosUseCase.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 9/25/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

protocol GetTodosListInteractorOutput {
    
    func todosLoaded(todos: [TodoItem])
    
    func todosLoadFailed(withError error: Error)
}

protocol GetTodosListInteractorInput {
    
    func getTodos()
}

class GetTodosListInteractor: GetTodosListInteractorInput {
    
    private let output: GetTodosListInteractorOutput
    private let dataSource: TodosDataSource
    
    init(output: GetTodosListInteractorOutput, dataSource: TodosDataSource) {
        self.output = output
        self.dataSource = dataSource
    }
    
    func getTodos() {
        dataSource.getAllTodos { [output] result in
            switch result {
            case let .failure(error): output.todosLoadFailed(withError: error)
            case let .success(todos): output.todosLoaded(todos: todos)
            }
        }
    }
}
