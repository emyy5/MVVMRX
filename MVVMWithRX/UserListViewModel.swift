//
//  UserListViewModel.swift
//  MVVMWithRX
//
//  Created by Eman Khaled on 29/09/2023.
//

import Foundation
import RxSwift
import RxCocoa
class UserListViewModel{
    let users: BehaviorRelay<[User]> = BehaviorRelay(value: [])

      func addUser(firstName: String, lastName: String) {
          let newUser = User(firstName: firstName, lastName: lastName)
          var currentUsers = users.value
          currentUsers.append(newUser)
          users.accept(currentUsers)
      }

      func deleteUser(at index: Int) {
          var currentUsers = users.value
          currentUsers.remove(at: index)
          users.accept(currentUsers)
      }
    
}
