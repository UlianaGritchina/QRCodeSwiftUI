
import SwiftUI

@main
struct QRCodeSwiftUIApp: App {
    @StateObject var listViewModel: SavedCodesViewViewModel = SavedCodesViewViewModel()
    var body: some Scene {
        WindowGroup {
            TabViewView()
                .environmentObject(listViewModel)
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
