//
//  TodoDetailInteractor.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 17/11/2020.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

protocol TodoDetailInteractorInput {
    func getTodo(byId id: String)
    
    func finishTodo(_ todo: TodoItem)
    
    func update(todo: TodoItem)
}

protocol TodoDetailInteractorOutput {
    
    func didFetch(todoItem todo: TodoItem)
    
    func errorFetchingTodo(withId todoId: String, error: Error)
    
    func didFinish(todo: TodoItem)
    
    func errorFinishingTodo(withId todoId: String, error: Error)
    
    func didUpdate(todo: TodoItem)
    
    func errorUpdatingTodo(_ todo: String, error: Error)
}

class TodoDetailInteractor: TodoDetailInteractorInput {
    
    private let datasource: TodosDataSource
    private let output: TodoDetailInteractorOutput
    
    init(datasource: TodosDataSource, output: TodoDetailInteractorOutput) {
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
    
    func update(todo: TodoItem) {
        datasource.update(todo: todo) { result in
            switch result {
            case let .success(todo):
                output.didFinish(todo: todo)
            case let .failure(error):
                output.errorFinishingTodo(withId: todo.id.uuidString, error: error)
            }
        }
    }
    
    func finishTodo(_ todo: TodoItem) {
        var finishedTodo = todo
        finishedTodo.finalize()
        datasource.update(todo: finishedTodo) { result in
            switch result {
            case let .success(todo):
                output.didFinish(todo: todo)
            case let .failure(error):
                output.errorFinishingTodo(withId: todo.id.uuidString, error: error)
            }
        }
        
    }
}
