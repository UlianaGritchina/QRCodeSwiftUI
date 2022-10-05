import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewModel()
    private let height = UIScreen.main.bounds.height
    private let width = UIScreen.main.bounds.width
    @State private var i = false
    let eyes = ["square", "roundedRect", "roundedpointingin", "roundedouter", "leaf", "circle", "squircle"]
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                Text("Link, email, some text")
                    .font(.headline)
                    .foregroundColor(.gray)
                VStack() {
                    textEditor
                    ColorPicker("Color",
                                selection: $vm.qrCodeColor).padding()
                    ColorPicker("Background color",
                                selection: $vm.backgroundColor).padding()
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation(.spring()) {
                                i.toggle()
                            }
                        }) {
                            Circle()
                                .frame(width: width / 7)
                                .foregroundColor(.white)
                                .shadow(color: Color("Color"), radius: 5, x: 0, y: 0)
                                .blur(radius: 0.5)
                                .overlay {
                                    Image("square")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.gray)
                                        .font(.headline)
                                }
                        }
                        .padding(.horizontal)
                        
                        Button(action: {
                            
                        }) {
                            Circle()
                                .frame(width: width / 7)
                                .foregroundColor(.white)
                                .shadow(color: Color("Color"), radius: 5, x: 0, y: 0)
                                .blur(radius: 0.5)
                                .overlay {
                                    Image("square")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.gray)
                                        .font(.headline)
                                }
                        }
                        .padding(.leading)
                        
                    }
                    .padding()
                }
                .padding(.horizontal)
            }
            
            VStack {
                Spacer()
                generateButton.padding(.bottom, 30)
            }
            .ignoresSafeArea()
            
            blackView
            QRCodeSheetView(
                vm: QRCodeSheetViewModel(
                    text: vm.text,
                    color1: vm.qrCodeColor,
                    color2: vm.backgroundColor),
                isShowingQR: $vm.isShowingQR
            )
            
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: width, height: height / 3)
                    .foregroundColor(.white)
                    .overlay {
                        VStack {
                            Text("Eye")
                                .font(.headline)
                            Spacer()
                            HStack {
                                ForEach(0..<4) { index in
                                    Circle()
                                        .frame(width: width / 7)
                                        .foregroundColor(.white)
                                        .shadow(color: Color("Color"), radius: 5, x: 0, y: 0)
                                        .blur(radius: 0.5)
                                        .overlay {
                                            Image(eyes[index])
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(.gray)
                                                .font(.headline)
                                        }
                                        .padding(.horizontal)
                                }
                            }
                            .padding()
                            HStack {
                                ForEach(4..<7) { index in
                                    Circle()
                                        .frame(width: width / 7)
                                        .foregroundColor(.white)
                                        .shadow(color: Color("Color"), radius: 5, x: 0, y: 0)
                                        .blur(radius: 0.5)
                                        .overlay {
                                            Image(eyes[index])
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(.gray)
                                                .font(.headline)
                                        }
                                        .padding(.horizontal)
                                }
                            }
                            Spacer()
                            
                        }
                        .padding()
                    }
            }
            .offset(y: i ? 0 : height)
            .onTapGesture {
                withAnimation(.spring()) {
                    i.toggle()
                }
            }
            .ignoresSafeArea()
            
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
            .frame(width: width - 40, height: height / 3)
            .cornerRadius(10)
            .shadow(color: Color("Color"), radius: 5, x: 0, y: 0)
    }
    
    private var generateButton: some View {
        Button(action: { withAnimation(.spring()) { vm.showQRCodeView() } }) {
            Text("Generate")
                .font(.headline)
                .frame(width: width - 80, height: 50)
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
            .opacity(vm.isShowingQR ? 0.4 : i ? 0.4 : 0)
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
