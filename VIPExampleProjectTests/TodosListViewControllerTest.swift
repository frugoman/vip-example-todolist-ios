//
//  TodosListViewControllerTest.swift
//  VIPExampleProjectTests
//
//  Created by Nicolas Frugoni on 9/25/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import XCTest
@testable import VIPExampleProject

class GetTodosListInteractorInputMock: GetTodosListInteractorInput {
   
    var didCallGetTodos = false
    
    func getTodos() {
        didCallGetTodos = true
    }
}

class TodosListRouterInputMock: TodosListRouterInput {
    
    var didRouteTo: TodosListRouterScreens?
    
    func route(to screen: TodosListRouterScreens) {
        didRouteTo = screen
    }
}

class TodosListViewControllerTest: XCTestCase {

    func testViewLoadTodos() {
        let interactor = GetTodosListInteractorInputMock()
        let router = TodosListRouterInputMock()
        let sut = TodosListViewController(interactor: interactor, router: router)
        sut.viewDidLoad()
        XCTAssertTrue(interactor.didCallGetTodos)
        XCTAssertNil(router.didRouteTo)
    }

}
