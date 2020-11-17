//
//  TodoDetailInteractor.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 17/11/2020.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

protocol GetTodoByIdInteractorInput {
    func getTodo(byId id: String)
}

protocol GetTodoByIdInteractorOutput {
    
    func didFetch(todoItem todo: TodoItem)
    
    func errorFetchingTodo(withId todoId: String, error: Error)
}

class GetTodoByIdInteractor: GetTodoByIdInteractorInput {
    
    private let datasource: TodosDataSource
    private let output: GetTodoByIdInteractorOutput
    
    init(datasource: TodosDataSource, output: GetTodoByIdInteractorOutput) {
        self.datasource = datasource
        self.output = output
    }
    
    func getTodo(byId id: String) {
        datasource.get(byId: id) { (result) in
            switch result {
            case let .success(todo):
                output.didFetch(todoItem: todo)
            case let .failure(error):
                output.errorFetchingTodo(withId: id, error: error)
            }
        }
    }
}
