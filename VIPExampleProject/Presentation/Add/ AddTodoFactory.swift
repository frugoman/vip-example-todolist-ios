//
//   AddTodoFactory.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 10/1/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import Foundation

class AddTodoFactory {
    
    func makeViewController(withDelegate delegate: AddTodoInteractorDelegate) -> AddTodoViewController {
        let router = AddTodoRouter()
        let interactor = AddTodoInteractor(dataSource: UserDefaultsTodosDataSource(), router: router, delegate: delegate)
        let vc = AddTodoViewController(interactor: interactor)
        router.viewController = vc
        return vc
    }
}
