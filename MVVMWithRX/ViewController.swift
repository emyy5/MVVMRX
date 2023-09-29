//
//  ViewController.swift
//  MVVMWithRX
//
//  Created by Eman Khaled on 29/09/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fistNameTF: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var lastNameTF: UITextField!
   
    private let disposeBag = DisposeBag()
    private let userListViewModel = UserListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Bind the users array to the table view
        userListViewModel.users
            .bind(to: tableView.rx.items(cellIdentifier: "userCell")) { _, user, cell in
                if let cell = cell as? UserTableViewCell {
                    cell.myLabel.text = "\(user.firstName) \(user.lastName)"
                }
            }
            .disposed(by: disposeBag)

        // Bind the addButton tap to add a new user
        addBtn.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance) // Debounce to prevent rapid taps
            .subscribe(onNext: { [weak self] in
                guard let firstName = self?.fistNameTF.text, !firstName.isEmpty,
                      let lastName = self?.lastNameTF.text, !lastName.isEmpty else {
                    return
                }
                self?.userListViewModel.addUser(firstName: firstName, lastName: lastName)
                self?.fistNameTF.text = ""
                self?.lastNameTF.text = ""
            })
            .disposed(by: disposeBag)

        // Enable table view editing mode
        tableView.isEditing = true

        // Bind the table view delete action to delete users
        tableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                self?.userListViewModel.deleteUser(at: indexPath.row)
            })
            .disposed(by: disposeBag)
    }
}
