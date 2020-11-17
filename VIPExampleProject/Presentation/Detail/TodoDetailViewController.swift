//
//  iOSTodosDetailFactory.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 16/11/2020.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import UIKit

class TodoDetailViewController: UIViewController {
    
    private let getByIdInteractor: GetTodoByIdInteractorInput
    private let updateInteractor: UpdateTodoInteractorInput
    private let finishInteractor: FinishTodoInteractorInput
    private let deleteInteractor: DeleteTodoInteractorInput
    private let todoId: String
    
    private let todoTitle = UITextField()
    private let finishButton = UIButton()
    private let deleteButton = UIButton()
    private var todo: TodoItem?
    
    init(
        todoId: String,
        getByIdInteractor: GetTodoByIdInteractorInput,
        updateInteractor: UpdateTodoInteractorInput,
        finishInteractor: FinishTodoInteractorInput,
        deleteInteractor: DeleteTodoInteractorInput
    ) {
        self.getByIdInteractor = getByIdInteractor
        self.updateInteractor = updateInteractor
        self.finishInteractor = finishInteractor
        self.deleteInteractor = deleteInteractor
        self.todoId = todoId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        self.title = "Unfinished"
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finishTodo)), animated: false)
        view.backgroundColor = .white
        view.addSubview(todoTitle)
        view.addSubview(finishButton)
        finishButton.autoPinEdge(.top, to: .bottom, of: todoTitle, withOffset: 20)
        finishButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        finishButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        finishButton.setTitle("Update", for: .normal)
        finishButton.setTitleColor(.link, for: .normal)
        finishButton.addTarget(self, action: #selector(updateTodo), for: .touchUpInside)
        view.addSubview(deleteButton)
        deleteButton.autoPinEdge(.top, to: .bottom, of: finishButton, withOffset: 20)
        deleteButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        deleteButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.systemRed, for: .normal)
        deleteButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20, relation: .greaterThanOrEqual)
        deleteButton.addTarget(self, action: #selector(deleteTodo), for: .touchUpInside)
        todoTitle.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), excludingEdge: .bottom)
        todoTitle.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getByIdInteractor.getTodo(byId: todoId)
    }
    
    @objc private func updateTodo() {
        guard var todo = todo, let title = todoTitle.text else { return }
        todo.title = title
        updateInteractor.update(todo: todo)
    }
    
    @objc private func deleteTodo() {
        guard let todo = todo else { return }
        deleteInteractor.deleteTodo(todo)
    }
    
    @objc private func finishTodo() {
        guard let todo = todo else { return }
        finishInteractor.finishTodo(todo)
    }
}

extension TodoDetailViewController: TodoDetailView {
    func update(todo: TodoItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func delete(todo: TodoItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func show(todo: TodoItem) {
        if todo.done {
            self.title = "Finished"
            navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(finishTodo)), animated: false)
        }
        todoTitle.text = todo.title
        self.todo = todo
    }
    
    func show(errorMessage message: String) {}
}
