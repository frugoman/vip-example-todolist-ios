//
//  TodosListViewControllerTest.swift
//  VIPExampleProjectTests
//
//  Created by Nicolas Frugoni on 9/25/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import XCTest
@testable import VIPExampleProject

class TodosListViewControllerDelegateMock: TodosListViewControllerDelegate {
   
    var didCallTappAddTodo = false
    var viewDidDisplay = false
    
    func viewDisplayed() {
        viewDidDisplay = true
    }
    
    func didTapAddTodo() {
        didCallTappAddTodo = true
    }
}

class GetTodosUseCaseInputMock: GetTodosUseCaseInput {
    var didCallLoad = false
    
    func loadTodos() {
        didCallLoad = true
    }
}

class TodosListViewControllerTest: XCTestCase {

    func testViewLoadTodos() {
        let delegate = TodosListViewControllerDelegateMock()
        let useCase = GetTodosUseCaseInputMock()
        let sut = ViewController(getTodosUseCase: useCase)
        sut.delegate = delegate
        sut.viewDidLoad()
        XCTAssertTrue(delegate.viewDidDisplay)
        XCTAssertTrue(useCase.didCallLoad)
    }

}
