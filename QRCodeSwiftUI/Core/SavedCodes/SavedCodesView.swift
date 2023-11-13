
import SwiftUI

struct SavedCodesView: View {
    @EnvironmentObject var vm: SavedCodesViewViewModel
    var body: some View {
        NavigationView {
            VStack {
                if !vm.codes.isEmpty {
                    List {
                        ForEach(vm.codes) { code in
                            SavedCodeRowView(code: code)
                        }
                        .onDelete(perform: vm.deleteItem)
                        .onMove(perform: vm.moveItem)
                    }
                } else {
                    Text("No saved QR codes yet").bold()
                }
            }
            .navigationTitle("Saved")
            .navigationBarItems(trailing: EditButton())
            .onAppear { vm.setQRs() }
        }
    }
    
}

struct SavedCodesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCodesView()
    }
}

