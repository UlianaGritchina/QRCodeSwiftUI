import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewViewModel()
    private let height = UIScreen.main.bounds.height
    private let width = UIScreen.main.bounds.width
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                Text("Link, email, some text")
                    .font(.headline)
                    .foregroundColor(.gray)
                VStack() {
                    textEditor
                    ColorPicker("Color", selection: $vm.qrCodeColor)
                        .padding()
                    ColorPicker("Backgrund color", selection: $vm.bacgroundColor)
                        .padding()
                    generateButton.padding(.top, height / 5)
                }
                .padding(.horizontal)
            }
            
            blackView
            QRCodeSheetView(text: vm.text,
                            color: vm.qrCodeColor,
                            color2: vm.bacgroundColor, isShowingQR: $vm.isShowingQR)
            
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
            .frame(width: UIScreen.main.bounds.width - 40,
                   height: UIScreen.main.bounds.height / 3)
            .cornerRadius(10)
            .shadow(color: Color("Color"), radius: 5, x: 0, y: 0)
    }
    
    private var generateButton: some View {
        Button(action: {withAnimation(.spring()) {
            vm.isShowingQR.toggle()
        }}) {
            Text("Generate")
                .font(.headline)
                .frame(width: UIScreen.main.bounds.width - 80,
                       height: 50)
                .foregroundColor(Color("text"))
                .background(Color("Button"))
                .cornerRadius(10)
                .shadow(color: Color("Color"), radius: 5, x: 0, y: 0)
        }
    }
    
    private var blackView: some View {
        Rectangle()
            .ignoresSafeArea()
            .foregroundColor(.black)
            .opacity(vm.isShowingQR ? 0.3 : 0)
    }
    
    private var doneButtonForToolBar: some View {
        HStack {
            Spacer()
            Button("Done") { UIApplication.shared.endEditing() }
        }
    }
    
    private var restButton: some View {
        Button("Rest") { vm.text = "" }
    }
    
    private var savedQrsButton: some View {
        Button(action: {}) {
            NavigationLink(destination: SavedCodesView()) {
                Image(systemName: "list.bullet")
            }
        }
    }
    
}
