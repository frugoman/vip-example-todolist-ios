//
//  TodosDatasourceMock.swift
//  VIPExampleProjectTests
//
//  Created by Nicolas Frugoni on 18/11/2020.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

@testable import VIPExampleProject

class TodosDataSourceMock: TodosDataSource {
    
    var todos: [TodoItem] = []
    var error: Error?
    
    var totalTimesCalled = 0
    var didCallGetAllTodos = 0 { didSet { totalTimesCalled += 1 } }
    var didCallAdd = 0 { didSet { totalTimesCalled += 1 } }
    var didCallGetById = 0 { didSet { totalTimesCalled += 1 } }
    var didCallUpdate = 0 { didSet { totalTimesCalled += 1 } }
    var didCallDelete = 0 { didSet { totalTimesCalled += 1 } }
    
    func getAllTodos(callback: (Result<[TodoItem], Error>) -> Void) {
        didCallGetAllTodos += 1
        if let error = error {
            callback(.failure(error))
            return
        }
        callback(.success(todos))
    }
    
    func add(todoItem item: TodoItem, callback: (Result<TodoItem, Error>) -> Void) {
        didCallAdd += 1
        if let error = error {
            callback(.failure(error))
            return
        }
        callback(.success(item))
    }
    
    func get(byId id: String, callback: (Result<TodoItem, Error>) -> Void) {
        didCallGetById += 1
        if let error = error {
            callback(.failure(error))
            return
        }
        guard let todo = todos.first(where: { $0.id.uuidString == id }) else {
            return
        }
        callback(.success(todo))
    }
    
    func update(todo: TodoItem, callback: (Result<TodoItem, Error>) -> Void) {
        didCallUpdate += 1
        if let error = error {
            callback(.failure(error))
            return
        }
        callback(.success(todo))
    }
    
    func delete(todo id: String, callback: (Result<String, Error>) -> Void) {
        didCallDelete += 1
        if let error = error {
            callback(.failure(error))
            return
        }
        callback(.success(id))
    }
}
