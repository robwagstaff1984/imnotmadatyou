// UserViewModel.swift
import Foundation

class UserViewModel: ObservableObject {
    private var dataRepo = DataRepository()
    @Published var users: [String: Any]?

    func addUser(userId: String, isAdmin: Bool, lastTimeNotMad: String, totalTimesNotMad: Int) {
        let userData: [String: Any] = [
            "isAdmin": isAdmin,
            "lastTimeNotMad": lastTimeNotMad,
            "totalTimesNotMad": totalTimesNotMad
        ]
        dataRepo.addUser(userId: userId, userData: userData)
    }

    func loadUsers() {
        dataRepo.fetchUsers { [weak self] usersData in
            self?.users = usersData
        }
    }
}
