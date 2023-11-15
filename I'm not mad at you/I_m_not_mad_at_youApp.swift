import SwiftUI

@main
struct I_m_not_mad_at_youApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewModel = UserViewModel()

    var body: some Scene {
        WindowGroup {
            if viewModel.isAuthenticated {
                // Show the main content view for authenticated users
                ContentView()
            } else {
                // Show the landing page for non-authenticated users
                LandingPage()
                    .environmentObject(viewModel)
            }
        }
    }
}
