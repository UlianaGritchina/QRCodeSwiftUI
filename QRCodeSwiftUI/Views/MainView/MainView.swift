import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewViewModel()
    private let height = UIScreen.main.bounds.height
    private let width = UIScreen.main.bounds.width
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    Text("Link, email, some text")
                        .font(.headline)
                        .foregroundColor(.gray)
                    VStack(spacing: height / 2.9) {
                        textEditor
                        generateButton
                    }
                    .padding()
                }
                
                blackView
                QRCodeSheetView(text: vm.text, isShowingQR: $vm.isShowingQR)
                
            }
            .navigationTitle("QR")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
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
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
            .ignoresSafeArea(.keyboard, edges: .all)
    }
    
    private var generateButton: some View {
        Button(action: {withAnimation(.spring()) {
            vm.isShowingQR.toggle()
        }}) {
            Text("Generate")
                .font(.headline)
                .frame(width: UIScreen.main.bounds.width - 80,
                       height: 45)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
    
    private var blackView: some View {
        Rectangle()
            .ignoresSafeArea()
            .foregroundColor(.black)
            .opacity(vm.isShowingQR ? 0.3 : 0)
    }
    
}
