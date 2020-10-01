//
//  GetTodosUseCase.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 9/25/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

protocol TodosListInteractorDelegate {
    
    func todosLoaded(todos: [TodoItem])
    
    func todosLoadFailed(withError error: Error)
}

protocol TodosListInteractorInput {
    
    func loadTodos()
    
    func addTodo()
}

class TodosListInteractor: TodosListInteractorInput {
    
    private let router: TodosListRouter
    private let delegate: TodosListInteractorDelegate
    private let dataSource: TodosDataSource
    
    init(delegate: TodosListInteractorDelegate, router: TodosListRouter, dataSource: TodosDataSource) {
        self.delegate = delegate
        self.router = router
        self.dataSource = dataSource
    }
    
    func loadTodos() {
        dataSource.getAllTodos { [delegate] result in
            switch result {
            case let .failure(error): delegate.todosLoadFailed(withError: error)
            case let .success(todos): delegate.todosLoaded(todos: todos)
            }
        }
    }
    
    func addTodo() {
        router.route(to: .newTodo)
    }
}
