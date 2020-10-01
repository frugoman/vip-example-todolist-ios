//
//  TodosListFactory.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 10/1/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import Foundation

class TodosListFactory {
    func makeViewController() -> TodosListViewController {
        let presenter = TodosListPresenter()
        let inMemory = UserDefaultsTodosDataSource()
        let router = TodosListRouter(detailFactory: TodoDetailFactory(), addFactory: AddTodoFactory())
        let interactor = TodosListInteractor(delegate: presenter, router: router, dataSource: inMemory)
        let list = TodosListViewController(interactor: interactor)
        router.rootViewController = list
        presenter.view = list
        
        return list
    }
}
