//
//  TodoDetailFactory.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 10/1/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import UIKit

protocol TodoDetailView: class {

    func show(errorMessage message: String)
    
    func show(todo: TodoItem)
    
    func update(todo: TodoItem)
    
    func delete(todo: TodoItem)
}

class TodoDetailPresenter {
    
    weak var view: TodoDetailView?
}

extension TodoDetailPresenter: GetTodoByIdInteractorOutput {
    
    func didFetch(todoItem todo: TodoItem) {
        view?.show(todo: todo)
    }
    
    func errorFetchingTodo(withId todoId: String, error: Error) {
        view?.show(errorMessage: "Can't find todo, try again later.")
    }
}

extension TodoDetailPresenter: FinishTodoInteractorOutput {
    
    func didFinish(todo: TodoItem) {
        view?.update(todo: todo)
    }
    
    func errorFinishingTodo(withId todoId: String, error: Error) {
        view?.show(errorMessage: "Can't finish todo, try again later.")
    }
}

extension TodoDetailPresenter: UpdateTodoInteractorOutput {
    
    func didUpdate(todo: TodoItem) {
        view?.update(todo: todo)
    }
    
    func errorUpdatingTodo(_ todo: TodoItem, error: Error) {
        view?.show(errorMessage: "Can't update todo, try again later.")
    }
}

extension TodoDetailPresenter: DeleteTodoInteractorOutput {
    
    func didDelete(todo: TodoItem) {
        view?.delete(todo: todo)
    }
    
    func errorDeletingTodo(_ todo: TodoItem, error: Error) {
        view?.show(errorMessage: "Can't delete todo, try again later.")
    }
}
