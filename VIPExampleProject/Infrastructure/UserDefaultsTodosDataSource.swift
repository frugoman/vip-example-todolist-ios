//
//  InMemoryTodosDataSource.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 9/25/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import Foundation

class UserDefaultsTodosDataSource: TodosDataSource {
    
    struct TodoItemRepreesntation: Codable {
        let title: String
    }
    
    func getAllTodos(callback: (Result<[TodoItem], Error>) -> Void) {
        guard let data = UserDefaults.standard.data(forKey: "todos") else {
            callback(.success([]))
            return
        }
        do {
            let todos = try JSONDecoder().decode([TodoItemRepreesntation].self, from: data)
            callback(.success(todos.map { TodoItem(title: $0.title) } ))
        } catch {
            callback(.failure(error))
        }
    }
    
    func add(todoItem item: TodoItem, callback: (Result<TodoItem, Error>) -> Void) {
        getAllTodos { (result) in
            switch result {
            case var .success(todos):
                todos.append(item)
                do {
                    let data = try JSONEncoder().encode(todos.map { TodoItemRepreesntation(title: $0.title) })
                    UserDefaults.standard.setValue(data, forKey: "todos")
                    callback(.success(item))
                } catch {
                    callback(.failure(error))
                }
            case let .failure(error):
                callback(.failure(error))
            }
        }
        
    }
}
