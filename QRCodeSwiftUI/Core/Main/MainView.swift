import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel
    init(editingQR: QRCode? = nil) {
        let vm = MainViewModel(editingQRCode: editingQR)
        _viewModel = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    header
                    textEditor
                    colorPickers
                }
                .padding(.horizontal)
            }
            .navigationTitle(viewModel.navigationTitle)
            .background(BackgroundView())
            .overlay { generateButton }
            .toolbar {
                restButton
                doneButtonForToolBar
            }
            .sheet(isPresented: $viewModel.isShowingQR, content: {
                GeneratedQRView(qrCode: viewModel.generatedQRCode)
            })
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
    
    private var header: some View {
        Text("Link, email, some text")
            .font(.headline)
            .foregroundColor(.gray)
    }
    
    private var textEditor: some View {
        TextEditor(text: $viewModel.text)
            .frame(height: UIScreen.main.bounds.height / 4)
            .frame(maxWidth: 700)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray.opacity(0.4), lineWidth: 0.5)
            }
    }
    
    private var colorPickers: some View {
        VStack(spacing: 30) {
            ColorPicker("Color", selection: $viewModel.foregroundColor)
            ColorPicker("Background color", selection: $viewModel.backgroundColor)
        }
        .padding(.top)
    }
    
    private var generateButton: some View {
        VStack {
            Spacer()
            ButtonView(
                title: viewModel.generateButtonTitle,
                action: viewModel.showQRCodeView
            )
            .padding()
            .padding(.bottom, viewModel.isEditView ? 20 : 80)
            .background(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
    
    private var doneButtonForToolBar: some ToolbarContent {
        ToolbarItem(placement: .keyboard) {
            Button("Done") { UIApplication.shared.endEditing() }
                .padding(.leading, UIScreen.main.bounds.width - 80)
        }
    }
    
    private var restButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Rest") { viewModel.rest() }
        }
    }
    
}
