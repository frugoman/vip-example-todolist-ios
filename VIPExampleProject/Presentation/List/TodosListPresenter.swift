//
//  TodosListPresenter.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 9/25/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

protocol TodosListView: class {
    func show(todos: [TodoItem])
    
    func showEmptyState()
    
    func show(errorMessage message: String)
}

class TodosListPresenter: GetTodosListInteractorOutput {
    
    weak var view: TodosListView?
    
    func todosLoaded(todos: [TodoItem]) {
        guard todos.count > 0 else {
            view?.showEmptyState()
            return
        }
        view?.show(todos: todos)
    }
    
    func todosLoadFailed(withError error: Error) {
        view?.show(errorMessage: "An error occured loading TODOs")
    }
}
