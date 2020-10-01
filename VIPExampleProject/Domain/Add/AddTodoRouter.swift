//
//  AddTodoRouter.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 10/1/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import Foundation

protocol AddTodoRouterInput {
    func close()
}

class AddTodoRouter: AddTodoRouterInput {
    
    weak var viewController: AddTodoViewController?
    
    func close() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
