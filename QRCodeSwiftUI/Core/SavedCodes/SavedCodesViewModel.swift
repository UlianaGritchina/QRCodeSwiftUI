
import Foundation

class SavedCodesViewViewModel: ObservableObject {
    
    @Published var codes: [QRCode] = []
    
    private let userDefaultsManager = UserDefaultsManager.shared
    
    init() {
        setQRs()
    }
    
    func setQRs() {
        userDefaultsManager.setSavedQrs(for: &codes)
        codes = codes.sorted(by: { $0.dateCreated > $1.dateCreated})
    }
    
}
