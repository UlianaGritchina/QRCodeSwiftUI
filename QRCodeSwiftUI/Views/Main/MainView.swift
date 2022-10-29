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
                VStack() {
                    textEditor
                    ColorPicker("Color",
                                selection: $vm.qrCodeColor).padding()
                    ColorPicker("Background color",
                                selection: $vm.backgroundColor).padding()
                    
                    shapesButtons.padding()
                    
                }
                .padding(.horizontal)
            }
            
            VStack {
                Spacer()
                generateButton.padding(.bottom)
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
            eyesView
                .offset(y: vm.isShowingEyes ? 0 : height)
                .onTapGesture {
                    withAnimation(.spring()) {
                        vm.isShowingEyes.toggle()
                    }
                }
                .ignoresSafeArea()
            
            dataView
                .offset(y: vm.isShowingData ? 0 : height)
                .onTapGesture {
                    withAnimation(.spring()) { vm.isShowingData.toggle() }
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
            .frame(width: width - 40, height: height / 4)
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
                .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 0)
        }
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
    
    private var shapesButtons: some View {
        HStack(spacing: 35) {
            Spacer()
            VStack {
                CircleButtonView(
                    imageName: vm.selectedEye,
                    action: { vm.showEyesSheet() }
                )
                Text("Eye")
            }
            
            VStack {
                CircleButtonView(
                    imageName: vm.selectedData,
                    action: { vm.showDataSheet()}
                )
                Text("Data")
            }
        }
    }
    
    private var eyesView: some View {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 10)
                .frame(width: width, height: height / 3)
                .foregroundColor(Color("sheet"))
                .overlay {
                    VStack {
                        Text("Eye").font(.headline)
                        Spacer()
                        HStack {
                            ForEach(0..<3) { index in
                                CircleButtonView(
                                    imageName: vm.eyes[index],
                                    action: { vm.selectEye(index: index) }
                                )
                                .padding(.horizontal)
                            }
                        }
                        .padding()
                        HStack {
                            ForEach(3..<7) { index in
                                CircleButtonView(
                                    imageName: vm.eyes[index],
                                    action: { vm.selectEye(index: index) }
                                )
                                .padding(.horizontal)
                            }
                        }
                        Spacer()
                        
                    }
                    .padding()
                }
        }
    }
    
    
    private var dataView: some View {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 10)
                .frame(width: width, height: height / 3)
                .foregroundColor(Color("sheet"))
                .overlay {
                    VStack {
                        Text("Data")
                            .font(.headline)
                        Spacer()
                        HStack {
                            ForEach(0..<2) { index in
                                CircleButtonView(
                                    imageName: vm.data[index],
                                    action: { vm.selectData(index: index) }
                                )
                                .padding(.horizontal)
                            }
                        }
                        .padding()
                        HStack {
                            ForEach(2..<5) { index in
                                CircleButtonView(
                                    imageName: vm.data[index],
                                    action: { vm.selectData(index: index) }
                                )
                                .padding(.horizontal)
                            }
                        }
                        Spacer()
                        
                    }
                    .padding()
                }
        }
    }
}

