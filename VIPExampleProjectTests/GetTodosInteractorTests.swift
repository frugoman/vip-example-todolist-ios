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
        let dataSource = TodosDataSourceMock()
        dataSource.todos = todos
        let delegate = GetTodosDelegateMock()
        let sut = GetTodosListInteractor(output: delegate, dataSource: dataSource)
        sut.getTodos()
        
        XCTAssertEqual(try XCTUnwrap(delegate.loaded).count, todos.count)
        XCTAssertEqual(try XCTUnwrap(delegate.loaded)[0], todos[0])
        XCTAssertNil(delegate.error)
    }
    
    func testGetTodosFailedThenCallError() throws {
        let error = NSError(domain: "", code: 1, userInfo: nil)
        let dataSource = TodosDataSourceMock()
        dataSource.error = error
        let delegate = GetTodosDelegateMock()
        let sut = GetTodosListInteractor(output: delegate, dataSource: dataSource)
        sut.getTodos()
        
        XCTAssertNil(delegate.loaded)
        XCTAssertNotNil(delegate.error)
    }
}

class GetTodosDelegateMock: GetTodosListInteractorOutput {
    
    var loaded: [TodoItem]?
    var error: Error?
    
    func todosLoaded(todos: [TodoItem]) {
        loaded = todos
    }
    
    func todosLoadFailed(withError error: Error) {
        self.error = error
    }
}
