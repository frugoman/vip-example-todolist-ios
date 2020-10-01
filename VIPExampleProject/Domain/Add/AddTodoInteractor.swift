//
//  AddTodoInteractor.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 10/1/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import Foundation

protocol AddTodoInteractorInput {
    
    func add(todo item: TodoItem)
    
    func cancel()
}

protocol AddTodoInteractorDelegate {
    
    func showNewTodo(_ todo: TodoItem)
}

class AddTodoInteractor: AddTodoInteractorInput {
    
    private let dataSource: TodosDataSource
    private let router: AddTodoRouter
    private let delegate: AddTodoInteractorDelegate
    
    init(dataSource: TodosDataSource, router: AddTodoRouter, delegate: AddTodoInteractorDelegate) {
        self.dataSource = dataSource
        self.router = router
        self.delegate = delegate
    }
    
    func add(todo item: TodoItem) {
        dataSource.add(todoItem: item) { (result) in
            switch result {
            case let .success(todoItem):
                delegate.showNewTodo(todoItem)
                router.close()
            case .failure(_):
                router.close()
            }
        }
    }
    
    func cancel() {
        router.close()
    }
}
