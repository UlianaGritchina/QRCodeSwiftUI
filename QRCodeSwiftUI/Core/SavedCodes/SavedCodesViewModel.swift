
import Foundation

class SavedCodesViewViewModel: ObservableObject {
    
    @Published var codes: [QRCode] = []
    
    private let userDefaultsManager = UserDefaultsManager.shared
    
    init() {
        setQRs()
    }
    
    func setQRs() {
        codes = userDefaultsManager.getSavedQRs()
            .sorted(by: { $0.dateCreated > $1.dateCreated})
    }
    
}
