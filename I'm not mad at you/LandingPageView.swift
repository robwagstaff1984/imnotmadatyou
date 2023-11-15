import SwiftUI

struct LandingPage: View {
    @EnvironmentObject var viewModel: UserViewModel

    var body: some View {
        VStack {
            Text("If you're not mad at Steph, then you would just sign up")
                .font(.largeTitle)
                .padding(.bottom, 20)

            Image("YourAppLogo") // Replace with your app's logo


            Button("Sign in with Email") {
                // Trigger email/password sign-in flow
                viewModel.presentFirebaseAuthUI()
            }
            .buttonStyle(.bordered)

            Button("Sign in with Google") {
                // Trigger Google Sign-In flow
                viewModel.signInWithGoogle(completion: { authDataResult, error in
                    
                })
            }
            .buttonStyle(.bordered)

            // Add more sign-in buttons as needed (e.g., Facebook)

            Spacer()
        }
        .padding()
    }
}
