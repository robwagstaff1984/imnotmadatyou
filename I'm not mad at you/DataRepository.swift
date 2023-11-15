// DataRepository.swift
import FirebaseDatabase

class DataRepository {
    private var ref: DatabaseReference!
    @Published var usersData: [String: Any] = [:]
    
    init() {
        ref = Database.database(url: "https://im-not-mad-at-you-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    }

    func addUser(userId: String, userData: [String: Any]) {
        ref.child("users").child(userId).setValue(userData)
    }
    
    func fetchUsers(completion: @escaping ([String: Any]?) -> Void) {
        
        // Fetching current user's data from Firebase
        ref.child("users")
            .child("moWmXy82nYgkEfidEWUzwLUfpgN2")
            .observeSingleEvent(of: .value, with: { snapshot in
                if let userData = snapshot.value as? [String: AnyObject] {
                    print("Current user's data: \(userData)")
                } else {
                    print("User data not found.")
                }
            })
        
        
        ref.child("users").observeSingleEvent(of: .value, with: { snapshot in
            if let value = snapshot.value as? [String: Any] {
                self.usersData = value
                // For debugging: print all users data
                print("All users data: \(self.usersData)")
            }
        }) { error in
            print(error.localizedDescription)
        }
    }
}
