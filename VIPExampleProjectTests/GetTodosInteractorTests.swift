//
//  GetTodosInteractorTests.swift
//  VIPExampleProjectTests
//
//  Created by Nicolas Frugoni on 9/25/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import XCTest
@testable import VIPExampleProject

class GetTodosInteractorTests: XCTestCase {

    func testGetTodosSuccessThenCallLoaded() throws {
        let todos = [TodoItem(title: "Title")]
        let dataSource = SuccessTodosDataSourceMock(todos)
        let delegate = GetTodosDelegateMock()
        let sut = GetTodosUseCase(delegate: delegate, dataSource: dataSource)
        sut.loadTodos()
        
        XCTAssertEqual(try XCTUnwrap(delegate.loaded).count, todos.count)
        XCTAssertEqual(try XCTUnwrap(delegate.loaded)[0], todos[0])
        XCTAssertNil(delegate.error)
    }
    
    func testGetTodosFailedThenCallError() throws {
        let error = NSError(domain: "", code: 1, userInfo: nil)
        let dataSource = FailureTodosDataSourceMock(error)
        let delegate = GetTodosDelegateMock()
        let sut = GetTodosUseCase(delegate: delegate, dataSource: dataSource)
        sut.loadTodos()
        
        XCTAssertNil(delegate.loaded)
        XCTAssertNotNil(delegate.error)
    }
}

class GetTodosDelegateMock: GetTodosDelegate {
    
    var loaded: [TodoItem]?
    var error: Error?
    
    func todosLoaded(todos: [TodoItem]) {
        loaded = todos
    }
    
    func todosLoadFailed(withError error: Error) {
        self.error = error
    }
}

class SuccessTodosDataSourceMock: TodosDataSource {
    let todos: [TodoItem]
    
    init(_ todos: [TodoItem] = []) {
        self.todos = todos
    }
    
    func getAllTodos(callback: (Result<[TodoItem], Error>) -> Void) {
        callback(.success(todos))
    }
}

class FailureTodosDataSourceMock: TodosDataSource {
    let error: Error
    
    init(_ error: Error) {
        self.error = error
    }
    
    func getAllTodos(callback: (Result<[TodoItem], Error>) -> Void) {
        callback(.failure(error))
    }
}
