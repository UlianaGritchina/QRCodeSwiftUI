
import SwiftUI

@main
struct QRCodeSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var listViewModel: SavedCodesViewViewModel = SavedCodesViewViewModel()
    var body: some Scene {
        WindowGroup {
            TabViewView()
                .environmentObject(listViewModel)
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        configureTabBar()
        return true
    }
    
    private func configureTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}
