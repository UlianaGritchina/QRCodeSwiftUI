
import SwiftUI

struct SavedCodesView: View {
    @EnvironmentObject var vm: SavedCodesViewViewModel
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if !vm.codes.isEmpty {
                        qrsList
                    } else {
                        Text("No saved QR codes yet")
                            .bold()
                    }
                }
            }
            .navigationTitle("Saved")
            .background(BackgroundView())
            .onAppear { vm.setQRs() }
        }
    }
    
    private var qrsList: some View {
        VStack {
            ForEach(vm.codes) { code in
                SavedCodeRowView(code: code)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
        }
    }
    
}

struct SavedCodesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCodesView()
    }
}

