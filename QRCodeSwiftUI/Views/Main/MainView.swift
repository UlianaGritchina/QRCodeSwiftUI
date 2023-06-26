import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                contentView
                
                QRCodeSheetView(
                    vm: vm.getQRCodeViewModel(),
                    isShowingQR: $vm.isShowingQR
                )
            }
            .navigationTitle("QR")
            .animation(.spring(), value: vm.isShowingQR)
            .toolbar {
                restButton
                doneButtonForToolBar
            }
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
    
    
    private var contentView: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                header
                
                textEditor
                
                colorPickers
                    .padding(.bottom, 30)
                
                ButtonView(title: "Generate", action: vm.showQRCodeView)
            }
            .padding(.horizontal)
        }
    }
    private var header: some View {
        Text("Link, email, some text")
            .font(.headline)
            .foregroundColor(.gray)
    }
    
    private var textEditor: some View {
        TextEditor(text: $vm.text)
            .font(.headline)
            .frame(maxWidth: 700)
            .frame(height: UIScreen.main.bounds.height / 4)
            .cornerRadius(10)
            .shadow(color: .lightShadowColor, radius: 5, x: 0, y: 0)
    }
    
    private var colorPickers: some View {
        VStack(spacing: 30) {
            ColorPicker("Color", selection: $vm.qrCodeColor)
            ColorPicker("Background color", selection: $vm.backgroundColor)
        }
        .padding(.top)
    }
    
    private var doneButtonForToolBar: some ToolbarContent {
        ToolbarItem(placement: .keyboard) {
            Button("Done") { UIApplication.shared.endEditing() }
                .padding(.leading, UIScreen.main.bounds.width - 80)
        }
    }
    
    private var restButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Rest") { vm.rest() }
        }
    }
    
}
