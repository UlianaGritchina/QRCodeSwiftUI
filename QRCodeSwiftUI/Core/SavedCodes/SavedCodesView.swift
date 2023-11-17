
import SwiftUI

struct SavedCodesView: View {
    @EnvironmentObject var vm: SavedCodesViewViewModel
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                ScrollView {
                    if !vm.codes.isEmpty {
                        qrsList
                    } else {
                        Text("No saved QR codes yet")
                            .bold()
                    }
                }
            }
            .navigationTitle("Saved")
            .onAppear { vm.setQRs() }
        }
        .navigationViewStyle(.stack)
    }
    
    private var qrsList: some View {
        VStack {
            ForEach(vm.codes) { code in
                NavigationLink(destination: QRCodeDetailView(qrCode: code)) {
                    SavedCodeRowView(code: code)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
            }
        }
    }
    
}

struct SavedCodesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCodesView()
    }
}

