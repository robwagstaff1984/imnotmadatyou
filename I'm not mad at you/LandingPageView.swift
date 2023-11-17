import SwiftUI

struct LandingPage: View {
    @EnvironmentObject var viewModel: UserViewModel

    var body: some View {
        VStack {
            Text("If you're not mad at Steph, then you would just sign up")
                .font(.largeTitle)
                .padding(.bottom, 20)

            Image("YourAppLogo") // Replace with your app's logo


            Button("Sign up") {
                viewModel.presentFirebaseAuth()
            }
            .buttonStyle(.bordered)

            Spacer()
        }
        .padding()
    }
}
