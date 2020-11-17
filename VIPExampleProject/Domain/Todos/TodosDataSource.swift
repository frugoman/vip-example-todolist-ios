//
//  TodosDataSource.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 9/25/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

protocol TodosDataSource {
    typealias ListResult = (Result<[TodoItem], Error>) -> Void
    typealias SingleResult = (Result<TodoItem, Error>) -> Void
    
    func getAllTodos(callback: ListResult)
    
    func add(todoItem item: TodoItem, callback: SingleResult)
    
    func get(byId id: String, callback: SingleResult)
    
    func update(todo: TodoItem, callback: SingleResult)
    
    func delete(todo id: String, callback: (Result<String, Error>) -> Void)
    
}
