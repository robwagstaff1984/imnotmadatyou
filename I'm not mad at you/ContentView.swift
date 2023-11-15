// ContentView.swift
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = UserViewModel()

    var body: some View {
        VStack {
            // Your view code here
            Button("Create Inital Users") {
                viewModel.createInitialUsers()
            }
            Button("Load Users") {
                viewModel.loadUsers()
            }
            List(viewModel.users?.keys.sorted() ?? [], id: \.self) { key in
                Text(key)
                // Display user data here
            }
        }
    }
}
