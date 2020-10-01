//
//  TodosDataSource.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 9/25/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

protocol TodosDataSource {
    func getAllTodos(callback: (Result<[TodoItem], Error>) -> Void)
    
    func add(todoItem item: TodoItem, callback: (Result<TodoItem, Error>) -> Void) 
}
