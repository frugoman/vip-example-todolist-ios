//
//  AddTodoViewController.swift
//  VIPExampleProject
//
//  Created by Nicolas Frugoni on 10/1/20.
//  Copyright © 2020 Nicolas Frugoni. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController {
    
    private let interactor: AddTodoInteractorInput
    private let todoTitleField = UITextField()
    private let confirmButton = UIButton()
    
    init(interactor: AddTodoInteractorInput) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Add Todo"
        view.addSubview(todoTitleField)
        view.addSubview(confirmButton)
        todoTitleField.placeholder = "Eg: Go Shopping"
        todoTitleField.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        todoTitleField.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        todoTitleField.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        todoTitleField.becomeFirstResponder()
        
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapAddButton)), animated: false)
    }
    
    @objc private func didTapAddButton() {
        guard
            let todoTitle = todoTitleField.text,
            !todoTitle.isEmpty
        else { return }
        interactor.add(todoWithTitle: todoTitle)
        dismiss(animated: true, completion: nil)
    }
}
