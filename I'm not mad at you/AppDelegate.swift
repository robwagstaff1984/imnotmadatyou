import UIKit
import FirebaseDatabaseInternal
import FirebaseCore
import FirebaseAuth
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

//        // Sign in anonymously
//        Auth.auth().signInAnonymously { (authResult, error) in
//            guard let user = authResult?.user else {
//                print("Firebase anonymous login failed: \(error?.localizedDescription ?? "")")
//                return
//            }
//            let uid = user.uid
//            print("Signed in with UID: \(uid)")
//            // Continue with setting up your app
//        }
        
        
        setupPushNotifications(application: application)
        return true
    }

    private func setupPushNotifications(application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
        application.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Handle the registration of the push notification token
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Handle the failure of push notification token registration
    }
}
