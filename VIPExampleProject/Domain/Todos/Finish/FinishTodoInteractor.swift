//
//  TodoDetailInteractor.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 17/11/2020.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

protocol FinishTodoInteractorInput {

    func finishTodo(_ todo: TodoItem)
}

protocol FinishTodoInteractorOutput {
    
    func didFinish(todo: TodoItem)
    
    func errorFinishingTodo(withId todoId: String, error: Error)
}

class FinishTodoInteractor: FinishTodoInteractorInput {
    
    private let datasource: TodosDataSource
    private let output: FinishTodoInteractorOutput
    
    init(datasource: TodosDataSource, output: FinishTodoInteractorOutput) {
        self.datasource = datasource
        self.output = output
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
