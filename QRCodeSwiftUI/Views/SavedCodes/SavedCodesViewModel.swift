
import Foundation

class SavedCodesViewViewModel: ObservableObject {
    
    @Published var codes: [QRCode] = [] {
        didSet {
            saveCodes()
        }
    }
    
    let itemsKey: String = "codes_list"
    
    init() { getItems() }
    
    func moveItem(from: IndexSet, to: Int) {
        codes.move(fromOffsets: from, toOffset: to)
    }
    
    func deleteItem(indexSet: IndexSet) {
        codes.remove(atOffsets: indexSet)
    }
    
    func addQR(name: String, text: String, imageData: Data) {
        let newCode = QRCode(name: name, text: text, imageData: imageData)
        codes.append(newCode)
    }
    
    func saveCodes() {
        if let encodedData = try? JSONEncoder().encode(codes) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedCodes = try? JSONDecoder().decode([QRCode].self, from: data)
        else { return }

        codes = savedCodes
    }
    
}
