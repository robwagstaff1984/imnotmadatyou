import UIKit
import FirebaseDatabaseInternal
import FirebaseCore
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configure Firebase
        FirebaseApp.configure()
        

        // Register for push notifications
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
        application.registerForRemoteNotifications()

        var ref: DatabaseReference!

        ref = Database.database(url: "https://im-not-mad-at-you-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()

        // Adding JohnDoe
        ref.child("users").child("JohnDoe").setValue([
            "lastTimeNotMad": "\(Date.now)",
            "totalTimesNotMad": 5,
            "isAdmin": false
        ])

        // Adding Steph
        ref.child("users").child("Steph").setValue([
            "isAdmin": true
        ])

        
        //print
        
        ref.child("users").observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
                print("Users: \(snapshot.value!)")
            } else {
                print("No data available")
            }
        })

        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Handle the registration of the push notification token
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Handle the failure of push notification token registration
    }

    // Add other necessary methods for push notifications
}
