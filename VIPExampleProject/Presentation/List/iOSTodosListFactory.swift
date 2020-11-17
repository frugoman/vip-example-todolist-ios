//
//  iOSTodosListFactory.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 16/11/2020.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import UIKit

class iOSTodosListFactory {
    
    func makeViewController() -> UIViewController {
        let presenter = TodosListPresenter()
        let inMemory = UserDefaultsTodosDataSource()
        let router = TodosListRouter()
        let interactor = GetTodosListInteractor(delegate: presenter, output: inMemory)
        let list = TodosListViewController(interactor: interactor, router: router)
        router.rootViewController = list
        presenter.view = list
        
        return list
    }
}
