// ContentView.swift
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = UserViewModel()

    var body: some View {
        VStack {
            Button("Load Users") {
                viewModel.loadUsers()
            }
            List(viewModel.users?.keys.sorted() ?? [], id: \.self) { key in
                Text(key)
                // Display user data here
            }
            // Display user's displayName and profileText here.
        }
    }
}
