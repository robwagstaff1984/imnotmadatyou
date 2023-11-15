// DataRepository.swift
import FirebaseDatabase

class DataRepository {
    private var ref: DatabaseReference!

    init() {
        ref = Database.database(url: "https://im-not-mad-at-you-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    }

    func addUser(userId: String, userData: [String: Any]) {
        ref.child("users").child(userId).setValue(userData)
    }

    func fetchUsers(completion: @escaping ([String: Any]?) -> Void) {
        ref.child("users").observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
                completion(snapshot.value as? [String: Any])
            } else {
                completion(nil)
            }
        })
    }
}
