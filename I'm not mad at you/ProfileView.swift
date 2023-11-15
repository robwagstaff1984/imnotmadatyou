import SwiftUI

struct ProfileView: View {
    @ObservedObject var userViewModel: UserViewModel
    @State private var areYouMadText: String = ""
    @State private var anythingElseText: String = ""

    var body: some View {
        Form {
            TextField("Are you mad at Steph?",
                      text: $areYouMadText)
            TextField("Anything else you'd like to let Steph know?",
                      text: $anythingElseText)
            Button("Submit") {
                userViewModel.submitAdditionalInfo(areYouMadText: areYouMadText,
                                                   anythingElseText: anythingElseText)
            }
        }
//        Form {
//            
//            TextField("Are you mad at Steph?", text: $areYouMadText)
//            TextField("Anything else you'd like to let Steph know?", text: $anythingElseText)
//            Button("Submit") {
//                userViewModel.submitAdditionalInfo(areYouMadText: areYouMadText,
//                                                   anythingElseText: anythingElseText)
//            }
//        }
    }
}
