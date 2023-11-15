// DataRepository.swift
import FirebaseDatabase
import FirebaseAuth

class DataRepository {
    private var ref: DatabaseReference!
    @Published var usersData: [String: Any] = [:]
    
    init() {
        ref = Database.database(url: "https://im-not-mad-at-you-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
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
    
    func addUser(userId: String, userData: [String: Any]) {
        ref.child("users").child(userId).setValue(userData)
    }
    
    func updateUserProfile(displayName: String, profileText: String) {
        if let user = Auth.auth().currentUser {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = displayName
            changeRequest.commitChanges { error in
                if let error = error {
                    print("Error updating user profile: \(error.localizedDescription)")
                } else {
                    // Update the user's profile data in the database as well, if needed.
                    let userId = user.uid
                    let userData: [String: Any] = [
                        "displayName": displayName,
                        "profileText": profileText,
                    ]
                    self.addUser(userId: userId, userData: userData)
                }
            }
        }
    }
    
 
    func submitAdditionalInfo(areYouMadText: String, anythingElseText: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let additionalUserInfo: [String: Any] = [
            "areYouMadText": areYouMadText,
            "anythingElseText": anythingElseText
        ]

        // Update the additional information at the user's node
        ref.child("users").child(uid).updateChildValues(additionalUserInfo) { error, _ in
            if let error = error {
                print("Error saving additional info: \(error.localizedDescription)")
            } else {
                print("Additional info saved successfully")
            }
        }
    }

}
