//
//  TodoDetailInteractor.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 17/11/2020.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

protocol DeleteTodoInteractorInput {

    func deleteTodo(_ todo: TodoItem)
}

protocol DeleteTodoInteractorOutput {
    
    func didDelete(todo: TodoItem)
    
    func errorDeletingTodo(_ todo: TodoItem, error: Error)
}

class DeleteTodoInteractor: DeleteTodoInteractorInput {
    
    private let datasource: TodosDataSource
    private let output: DeleteTodoInteractorOutput
    
    init(datasource: TodosDataSource, output: DeleteTodoInteractorOutput) {
        self.datasource = datasource
        self.output = output
    }
    
    func deleteTodo(_ todo: TodoItem) {
        datasource.delete(todo: todo.id.uuidString) { result in
            switch result {
            case .success:
                output.didDelete(todo: todo)
            case let .failure(error):
                output.errorDeletingTodo(todo, error: error)
            }
        }
        
    }
}
