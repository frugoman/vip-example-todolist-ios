//
//  InMemoryTodosDataSource.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 9/25/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import Foundation

class UserDefaultsTodosDataSource: TodosDataSource {
    
    enum Errors: Error {
        case todoWithIdNotFound(id: String)
        case updateFailed(todo: TodoItem)
    }
    
    struct TodoItemRepreesntation: Codable {
        let id: String
        let title: String
        let done: Bool
        
        init(item: TodoItem) {
            id = item.id.uuidString
            title = item.title
            done = item.done
        }
    }
    
    func getAllTodos(callback: (Result<[TodoItem], Error>) -> Void) {
        getAllTodosRepresentations { result in
            switch result {
            case let .success(todos):
                callback(.success(todos.map { TodoItem(id: UUID(uuidString: $0.id)!, title: $0.title, done: $0.done) }))
            case let .failure(error):
                callback(.failure(error))
            }
        }
    }
    
    private func getAllTodosRepresentations(callback: (Result<[TodoItemRepreesntation], Error>) -> Void) {
        guard let data = UserDefaults.standard.data(forKey: "todos") else {
            callback(.success([]))
            return
        }
        do {
            let todos = try JSONDecoder().decode([TodoItemRepreesntation].self, from: data)
            callback(.success(todos))
        } catch {
            callback(.failure(error))
        }
    }
    
    func get(byId id: String, callback: (Result<TodoItem, Error>) -> Void) {
        getAllTodos { result in
            switch result {
            case let .success(todos):
                guard let first = todos.first(where: { $0.id.uuidString == id }) else {
                    callback(.failure(Errors.todoWithIdNotFound(id: id)))
                    return
                }
                callback(.success(first))
            case let .failure(error):
                callback(.failure(error))
            }
        }
    }
    
    func add(todoItem item: TodoItem, callback: (Result<TodoItem, Error>) -> Void) {
        getAllTodos { result in
            switch result {
            case var .success(todos):
                todos.append(item)
                do {
                    try save(todos: todos.map { TodoItemRepreesntation(item: $0) })
                    callback(.success(item))
                } catch {
                    callback(.failure(error))
                }
            case let .failure(error):
                callback(.failure(error))
            }
        }
    }
    
    private func save(todos: [TodoItemRepreesntation]) throws {
        let data = try JSONEncoder().encode(todos)
        UserDefaults.standard.setValue(data, forKey: "todos")
    }
    
    func update(todo: TodoItem, callback: (Result<TodoItem, Error>) -> Void) {
        getAllTodosRepresentations { result in
            switch result {
            case var .success(todos):
                guard
                    let index = todos.firstIndex(where: { $0.id == todo.id.uuidString })
                else {
                    callback(.failure(Errors.todoWithIdNotFound(id: todo.id.uuidString)))
                    return
                }
                todos.remove(at: index)
                todos.insert(TodoItemRepreesntation(item: todo), at: index)
                do {
                    try save(todos: todos)
                    callback(.success(todo))
                } catch {
                    callback(.failure(error))
                }
            case let .failure(error):
                callback(.failure(error))
            }
        }
    }
    
    func delete(todo id: String, callback: (Result<String, Error>) -> Void) {
        getAllTodosRepresentations { result in
            switch result {
            case var .success(todos):
                guard
                    let index = todos.firstIndex(where: { $0.id == id })
                else {
                    callback(.failure(Errors.todoWithIdNotFound(id: id)))
                    return
                }
                todos.remove(at: index)
                do {
                    try save(todos: todos)
                    callback(.success(id))
                } catch {
                    callback(.failure(error))
                }
            case let .failure(error):
                callback(.failure(error))
            }
        }
    }
}
