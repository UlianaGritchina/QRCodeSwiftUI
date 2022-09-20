
import SwiftUI

@main
struct QRCodeSwiftUIApp: App {
    @StateObject var listViewModel: SavedCodesViewViewModel = SavedCodesViewViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
            }
            .environmentObject(listViewModel)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
