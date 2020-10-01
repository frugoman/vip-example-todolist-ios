//
//  ViewController.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 9/25/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import UIKit
import PureLayout

class TodosListViewController: UIViewController {

    private let interactor: TodosListInteractor
    
    private let tableView = UITableView()
    private var todos = [TodoItem]()
    
    init(interactor: TodosListInteractor) {
        self.interactor = interactor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Todos"
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodoButtonAction)), animated: false)
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        tableView.dataSource = self
        tableView.delegate = self
        
        interactor.loadTodos()
    }
    
    @objc private func addTodoButtonAction() {
        interactor.addTodo()
    }
}

extension TodosListViewController: TodosListView {
    
    func show(todos: [TodoItem]) {
        self.todos = todos
        tableView.reloadData()
    }
    
    func show(errorMessage message: String) {
        let alert = UIAlertController(title: "Ups!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "retry", style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension TodosListViewController: AddTodoInteractorDelegate {
    func showNewTodo(_ todo: TodoItem) {
        interactor.loadTodos()
    }
}

extension TodosListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        delegate.didSelect(todo: todos[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = todos[indexPath.row].title
        return cell
    }
}
