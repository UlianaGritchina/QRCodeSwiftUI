
import Foundation

class SavedCodesViewViewModel: ObservableObject {
    
    @Published var codes: [QRCode] = [] {
        didSet {
            saveCodes()
        }
    }
    
    private let userDefaultsManager = UserDefaultsManager.shared
    
    init() {
        setQRs()
    }
    
    func moveItem(from: IndexSet, to: Int) {
        codes.move(fromOffsets: from, toOffset: to)
    }
    
    func deleteItem(indexSet: IndexSet) {
        codes.remove(atOffsets: indexSet)
    }
    
    func saveCodes() {
        userDefaultsManager.saveQrs(codes)
    }
    
    func setQRs() {
        codes = userDefaultsManager.getSavedQRs()
    }
    
}
