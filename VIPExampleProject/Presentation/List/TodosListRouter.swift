//
//  TodosListRouter.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 10/1/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import UIKit

enum TodosListRouterScreens {
    case newTodo, details(todo: TodoItem)
}

protocol TodosListRouterInput {
    
    func route(to screen: TodosListRouterScreens)
}

class TodosListRouter: TodosListRouterInput {
    
    weak var rootViewController: TodosListViewController?
    private var detailView = TodoDetailViewComposer()

    func route(to screen: TodosListRouterScreens) {
        guard let rootViewController = rootViewController else { fatalError("") }
        switch screen {
        case let .details(todo):
            let datasource = UserDefaultsTodosDataSource()
            let presenter = TodoDetailPresenter()
            let get = GetTodoByIdInteractor(datasource: datasource, output: presenter)
            let update = UpdateTodoInteractor(datasource: datasource, output: presenter)
            let finish = FinishTodoInteractor(datasource: datasource, output: presenter)
            let delete = DeleteTodoInteractor(datasource: datasource, output: presenter)
            let vc = TodoDetailViewController(
                todoId: todo.id.uuidString,
                getByIdInteractor: get,
                updateInteractor: update,
                finishInteractor: finish,
                deleteInteractor: delete
            )
            detailView.views =  [vc, rootViewController]
            presenter.view = detailView
            rootViewController.navigationController?.pushViewController(vc, animated: true)
        case .newTodo:
            let presenter = AddTodoPresenter()
            let interactor = AddTodoInteractor(dataSource: UserDefaultsTodosDataSource(), output: presenter)
            let vc = AddTodoViewController(interactor: interactor)
            presenter.view = rootViewController
            let navController = UINavigationController(rootViewController: vc)
            rootViewController.present(navController, animated: true, completion: nil)
        }
    }
}

class TodoDetailViewComposer: TodoDetailView {

    var views: [TodoDetailView] = []
    
    func update(todo: TodoItem) {
        views.forEach { $0.update(todo: todo) }
    }
    
    func delete(todo: TodoItem) {
        views.forEach { $0.delete(todo: todo) }
    }
    
    func show(errorMessage message: String) {
        views.forEach { $0.show(errorMessage: message) }
    }
    
    func show(todo: TodoItem) {
        views.forEach { $0.show(todo: todo) }
    }
    
}
