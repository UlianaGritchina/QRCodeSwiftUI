import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewModel()
    private let height = UIScreen.main.bounds.height
    private let width = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                Text("Link, email, some text")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                textEditor
                colorPickers
            }
            
            VStack {
                Spacer()
                ButtonView(title: "Generate", action: vm.showQRCodeView)
                    .padding(.bottom, 40)
            }
            .ignoresSafeArea()
            
            blackView
            
            QRCodeSheetView(
                vm: vm.getQRCodeViewModel(),
                isShowingQR: $vm.isShowingQR
            )
            
        }
        .navigationTitle("QR")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) { restButton }
            ToolbarItemGroup(placement: .navigationBarTrailing) {savedQrsButton}
            ToolbarItemGroup(placement: .keyboard) { doneButtonForToolBar }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainView()
        }
    }
}


//MARK: ELEMENTS

extension MainView {
    
    private var textEditor: some View {
        TextEditor(text: $vm.text)
            .font(.headline)
            .multilineTextAlignment(.leading)
            .frame(width: width - 40, height: height / 4)
            .cornerRadius(10)
            .shadow(color: .shadowColor, radius: 5, x: 0, y: 0)
    }
    
    private var colorPickers: some View {
        VStack(spacing: 30) {
            ColorPicker("Color", selection: $vm.qrCodeColor)
            ColorPicker("Background color", selection: $vm.backgroundColor)
        }
        .padding()
    }
    
    private var blackView: some View {
        Rectangle()
            .ignoresSafeArea()
            .foregroundColor(.black)
            .opacity(vm.isShowingQR
                     ? 0.4
                     : vm.isShowingEyes
                     ? 0.4
                     : vm.isShowingData
                     ? 0.4
                     : 0)
    }
    
    private var doneButtonForToolBar: some View {
        Button("Done") { UIApplication.shared.endEditing() }
            .padding(.leading, width - 80)
    }
    
    private var restButton: some View {
        Button("Rest") { vm.rest() }
    }
    
    private var savedQrsButton: some View {
        NavigationLink(destination: SavedCodesView()) {
            Image(systemName: "list.bullet")
        }
    }
    
}
