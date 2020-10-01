//
//  TodosListRouter.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 10/1/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import Foundation

enum TodosListRouterScreens {
    case newTodo, details(TodoItem)
}

protocol TodosListRouterInput {
    
    func route(to screen: TodosListRouterScreens)
}

class TodosListRouter: TodosListRouterInput {
    
    weak var rootViewController: TodosListViewController?
    private let detailFactory: TodoDetailFactory
    private let addFactory: AddTodoFactory
    
    init(detailFactory: TodoDetailFactory, addFactory: AddTodoFactory) {
        self.detailFactory = detailFactory
        self.addFactory = addFactory
    }
    
    func route(to screen: TodosListRouterScreens) {
        switch screen {
        case let .details(todo):
            rootViewController?.present(detailFactory.makeViewController(forTodo: todo), animated: true, completion: nil)
        case .newTodo:
            guard let rootViewController = rootViewController else { fatalError("") }
            rootViewController.present(addFactory.makeViewController(withDelegate: rootViewController), animated: true, completion: nil)
        }
    }
}
