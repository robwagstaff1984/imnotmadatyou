import Foundation
import FirebaseAuth
import FirebaseGoogleAuthUI
import FirebaseEmailAuthUI

class UserViewModel: ObservableObject {
    private var dataRepo = DataRepository()
    private var firebaseAuthDelegate = FirebaseAuthDelegate()
    @Published var isAuthenticated = false
    @Published var users: [String: Any]?
    
    init() {
        firebaseAuthDelegate = FirebaseAuthDelegate()
        firebaseAuthDelegate.userViewModel = self // Pass the ViewModel reference to the delegate
    }
    
    // Sign in with email and password
    func signInWithEmail(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    // Function to present the FirebaseUI Auth ViewController
    func presentFirebaseAuthUI() {
        // Get the default Auth UI object
        let authUI = FUIAuth.defaultAuthUI()
        guard let authViewController = authUI?.authViewController() else { return }

        // Set the delegate to handle responses
        authUI?.delegate = firebaseAuthDelegate  // Assuming you have a firebaseAuthDelegate

        // Configure the Auth UI for email/password authentication
        let emailAuthProvider = FUIEmailAuth()
        authUI?.providers = [emailAuthProvider]

        // Present the Auth view controller
        UIApplication.shared.windows.first?.rootViewController?.present(authViewController, animated: true, completion: nil)
    }
    
    func signInWithGoogle(completion: @escaping (AuthDataResult?, Error?) -> Void) {
        let authUI = FUIAuth.defaultAuthUI()
        guard let authViewController = authUI?.authViewController() else { return }

        UIApplication.shared.windows.first?.rootViewController?.present(authViewController, animated: true, completion: nil)

        authUI?.delegate = firebaseAuthDelegate // Use firebaseAuthDelegate here
    }
    
    // Register a new user with email and password
    func registerWithEmail(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
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
    
    func updateUserProfile(displayName: String, profileText: String) {
        // Update the user's profile information in Firebase Authentication.
        dataRepo.updateUserProfile(displayName: displayName, profileText: profileText)
    }
    
    func submitAdditionalInfo(areYouMadText: String, anythingElseText: String) {
        dataRepo.submitAdditionalInfo(areYouMadText: areYouMadText,
                                      anythingElseText: anythingElseText)
    }
}


class FirebaseAuthDelegate: NSObject, FUIAuthDelegate {
    weak var userViewModel: UserViewModel?

    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            print("Error during sign-in: \(error.localizedDescription)")
            userViewModel?.isAuthenticated = false
        } else if authDataResult?.user != nil {
            userViewModel?.isAuthenticated = true
        }
    }
}
