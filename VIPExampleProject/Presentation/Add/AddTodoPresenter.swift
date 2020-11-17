//
//  AddTodoPresenter.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 16/11/2020.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//


protocol AddTodoView: class {
    
    func display(newTodo: TodoItem)
    
    func show(errorMessage message: String)
}

class AddTodoPresenter: AddTodoInteractorOutput {
    
    weak var view: AddTodoView?
    
    func didCreate(todo: TodoItem) {
        view?.display(newTodo: todo)
    }
    
    func errorCreatingTodos(_ error: Error) {
        view?.show(errorMessage: "Couldn't add todo, try again later.")
    }
}
