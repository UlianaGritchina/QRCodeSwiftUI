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
                    qrPickerView
                    qrNameView
                    textEditor
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
    
    @ViewBuilder private var qrPickerView: some View {
        if !viewModel.isEditView {
            HStack {
                Text("QR Type:")
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                Spacer()
                qrPicker
            }
            .padding(.leading)
            .frame(height: 48)
            .background(Color.gray.opacity(0.25).cornerRadius(10).opacity(0.7))
        } else {
            Text(viewModel.qrType.rawValue)
                .font(.headline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder private var qrPicker: some View {
        Picker(selection: $viewModel.qrType, label: Text("Picker")) {
            ForEach([QRType.text, QRType.wifi]) { type in
                Text(type.rawValue).tag(type)
            }
        }
    }
    
    @ViewBuilder private var qrNameView: some View {
        if viewModel.isEditView {
            TextField("title", text: $viewModel.qrCodeName)
                .appTextFieldStyle()
        }
    }
    
    private var textEditor: some View {
        VStack {
            switch viewModel.qrType {
            case .text:
                qrTextEditor
            case .wifi:
                wifiQrCodeFields
            case .phone:
                phoneView
            default:
                Text("")
            }
        }
        .padding(.top)
    }
    
    private var qrTextEditor: some View {
        TextEditor(text: $viewModel.text)
            .frame(height: UIScreen.main.bounds.height / 4)
            .frame(maxWidth: 700)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray.opacity(0.4), lineWidth: 0.5)
            }
    }
    
    private var wifiQrCodeFields: some View {
        VStack(spacing: 15) {
            TextField("SSID", text: $viewModel.wifiSSID)
                .appTextFieldStyle()
            TextField("Password", text: $viewModel.wifiPassword)
                .appTextFieldStyle()
        }
    }
    
    private var phoneView: some View {
        TextField("phone number", text: $viewModel.phoneNumber)
            .appTextFieldStyle()
            .keyboardType(.numberPad)
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
