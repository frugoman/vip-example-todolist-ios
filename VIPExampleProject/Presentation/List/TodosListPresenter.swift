//
//  TodosListPresenter.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 9/25/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

protocol TodosListView {
    func show(todos: [TodoItem])
    
    func show(errorMessage message: String)
}

class TodosListPresenter: TodosListInteractorDelegate {
    
    var view: TodosListView?
    
    func todosLoaded(todos: [TodoItem]) {
        view?.show(todos: todos)
    }
    
    func todosLoadFailed(withError error: Error) {
        view?.show(errorMessage: "An error occured loading TODOs")
    }
}
