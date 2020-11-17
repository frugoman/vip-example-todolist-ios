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

    private let interactor: GetTodosListInteractor
    private let router: TodosListRouterInput
    
    private let emptyStateLabel = UILabel()
    private let tableView = UITableView()
    private var todos = [TodoItem]()
    
    init(interactor: GetTodosListInteractor, router: TodosListRouterInput) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Todos"
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodoButtonAction)), animated: false)
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(emptyStateLabel)
        emptyStateLabel.autoCenterInSuperview()
        emptyStateLabel.textColor = .label
        emptyStateLabel.font = .boldSystemFont(ofSize: 32)
        emptyStateLabel.text = "There's nothing to do!"
        emptyStateLabel.numberOfLines = 0
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20, relation: .greaterThanOrEqual)
        emptyStateLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20, relation: .greaterThanOrEqual)
        
        interactor.getTodos()
    }
    
    @objc private func addTodoButtonAction() {
        router.route(to: .newTodo)
    }
}

extension TodosListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard todos.indices.contains(indexPath.row) else { return }
        router.route(to: .details(todo: todos[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let todo = todos[indexPath.row]
        var title = todo.title
        if todo.done {
            title.append(" Done")
        }
        cell.textLabel?.text = title
        return cell
    }
    
    private func shouldHideList(_ shouldHide: Bool) {
        tableView.isHidden = shouldHide
        emptyStateLabel.isHidden = !shouldHide
    }
}

extension TodosListViewController: TodosListView {
    
    func showEmptyState() {
        shouldHideList(true)
    }
    
    func show(todos: [TodoItem]) {
        self.todos = todos
        tableView.reloadData()
        shouldHideList(false)
    }
    
    func show(errorMessage message: String) {
        let alert = UIAlertController(title: "Ups!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "retry", style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension TodosListViewController: AddTodoView {
    func display(newTodo: TodoItem) {
        todos.insert(newTodo, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        shouldHideList(false)
    }
}


extension TodosListViewController: TodoDetailView {
    
    func delete(todo: TodoItem) {
        guard let index = todos.firstIndex(where: { $0.id == todo.id }) else { return }
        todos.remove(at: index)
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        shouldHideList(todos.count == 0)
    }
    
    func update(todo: TodoItem) {
        guard let index = todos.firstIndex(where: { $0.id == todo.id }) else { return }
        todos.remove(at: index)
        todos.insert(todo, at: index)
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
    }
    
    func show(todo: TodoItem) {}
}
