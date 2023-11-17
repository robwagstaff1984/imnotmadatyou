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
    
    func presentFirebaseAuth() {
        guard let authUI = FUIAuth.defaultAuthUI() else { return }
        authUI.delegate = firebaseAuthDelegate
        
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(authUI: authUI),
            FUIEmailAuth()
        ]
        authUI.providers = providers
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(authUI.authViewController(), animated: true)
        }
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
