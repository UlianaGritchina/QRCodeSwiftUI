import SwiftUI

struct GenerateQRView: View {
    @StateObject var viewModel: ViewModel
    @Binding var editingQR: QRCode
    @Environment(\.dismiss) private var dismiss
    init(editingQR: Binding<QRCode>, isEditingView: Bool = false) {
        let vm = ViewModel(editingQRCode: editingQR.wrappedValue, isEditView: isEditingView)
        _viewModel = StateObject(wrappedValue: vm)
        _editingQR = editingQR
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    qrCodeTypePicker
                    qrTitleView
                    textEditor
                        .padding(.top)
                    colorPickers
                }
                .padding(.horizontal)
                .padding(.top, 5)
            }
            .navigationTitle(viewModel.navigationTitle)
            .background(BackgroundView())
            .overlay { generateButton }
            .toolbar {
                restButton
                closeButton
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
        GenerateQRView(editingQR: .constant(QRCode()))
    }
}

//MARK: ELEMENTS

extension GenerateQRView {
    
    @ViewBuilder private var qrCodeTypePicker: some View {
        if !viewModel.isEditView {
            Picker(selection: $viewModel.qrType, label: Text("Picker")) {
                Text("Link, email, some text").tag(QRType.text)
                Text("WI-Fi").tag(QRType.wifi)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder private var qrTitleView: some View {
        if viewModel.isEditView {
            TextField("title", text: $viewModel.qrTitle)
                .appTextFieldStyle()
        }
    }
    
    @ViewBuilder private var textEditor: some View {
        if viewModel.qrType == .text {
            TextEditor(text: $viewModel.content)
                .frame(height: UIScreen.main.bounds.height / 4)
                .frame(maxWidth: 700)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray.opacity(0.4), lineWidth: 0.5)
                }
        } else {
            VStack(spacing: 15) {
                TextField("SSID", text: $viewModel.wifiSSID)
                    .appTextFieldStyle()
                TextField("Password", text: $viewModel.wifiPassword)
                    .appTextFieldStyle()
            }
        }
    }
    
    private var colorPickers: some View {
        VStack(spacing: 30) {
            ColorPicker("Color", selection: $viewModel.foregroundColor)
            ColorPicker("Background color", selection: $viewModel.backgroundColor)
            Button(action: { viewModel.swapColors() }) {
                Text("Swap colors")
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.top)
    }
    
    private var generateButton: some View {
        VStack {
            Spacer()
            ButtonView(
                title: viewModel.generateButtonTitle,
                action: {
                    viewModel.generateButtonTapped()
                    if viewModel.isEditView {
                        editingQR = viewModel.editingQRCode
                        dismiss()
                    }
                }
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
    
    private var closeButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
            }
            .opacity(viewModel.isEditView ? 1 : 0)
        }
    }
}
