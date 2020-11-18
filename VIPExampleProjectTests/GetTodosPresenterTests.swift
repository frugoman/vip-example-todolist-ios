//
//  GetTodosPresenterTests.swift
//  VIPExampleProjectTests
//
//  Created by Nicolas Frugoni on 9/25/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import XCTest
@testable import VIPExampleProject

class TodosListViewMock: TodosListView {
    var list: [TodoItem]?
    var error: String?
    var didShowEmptyState = false
    
    func showEmptyState() {
        didShowEmptyState = true
    }
    
    func show(todos: [TodoItem]) {
        list = todos
    }
    
    func show(errorMessage message: String) {
        error = message
    }
}

class GetTodosPresenterTests: XCTestCase {

    func testShowTodos() {
        let todos = [TodoItem(title: "Title")]
        let view = TodosListViewMock()
        let sut = TodosListPresenter()
        sut.view = view
        sut.todosLoaded(todos: todos)
        
        XCTAssertFalse(view.didShowEmptyState)
        XCTAssertEqual(view.list, todos)
        XCTAssertNil(view.error)
    }
    
    func testWhenErrorThenShowErrorMessage() {
        let error = NSError(domain: "Domain", code: 1, userInfo: nil)
        let view = TodosListViewMock()
        let sut = TodosListPresenter()
        sut.view = view
        sut.todosLoadFailed(withError: error)
        
        XCTAssertFalse(view.didShowEmptyState)
        XCTAssertNil(view.list)
        XCTAssertEqual(view.error, "An error occured loading TODOs")
    }
}
