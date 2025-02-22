import SwiftUI

struct GenerateQRView: View {
    @StateObject var viewModel: ViewModel
    @Binding var editingQR: QRCode
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var photoPickerViewModel = PhotoPickerViewModel()
    
    init(editingQR: Binding<QRCode>, isEditingView: Bool = false) {
        let vm = ViewModel(editingQRCode: editingQR.wrappedValue, isEditView: isEditingView)
        _viewModel = StateObject(wrappedValue: vm)
        _editingQR = editingQR
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    qrNameView
                    textEditor
                    qrForeground
                    Divider()
                    qrBackground
                    if viewModel.isFirstEnter {
                        Text("Control the transparency of the color to adjust the background")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    Divider()
                    qrLogo
                    
                }
                .padding(.horizontal)
            }
            .navigationTitle(viewModel.navigationTitle)
            .background(BackgroundView())
            .overlay { generateButton }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    withAnimation {
                        viewModel.isFirstEnter = false
                    }
                }
            }
            .toolbar {
                reset
                closeButton
                doneButtonForToolBar
            }
            .sheet(isPresented: $viewModel.isShowingQR, content: {
                GeneratedQRView(qrCode: viewModel.generatedQRCode)
            })
            .sheet(isPresented: $viewModel.isShowPhotoPicker, onDismiss:  {
                if viewModel.qrImageType == .background {
                    viewModel.backgroundImageData = photoPickerViewModel.imageData
                } else {
                    viewModel.logoImageData = photoPickerViewModel.imageData
                }
            }) {
                PhotoPickerView(vm: photoPickerViewModel)
                    .ignoresSafeArea(edges: .bottom)
            }
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
            if viewModel.isEditView {
                Text(viewModel.qrType.rawValue)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
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
    
    private var qrForeground: some View {
        ColorPicker("Foreground", selection: $viewModel.foregroundColor)
            .font(.headline)
    }
    
    private var qrBackground: some View {
        HStack {
            ColorPicker("Background", selection: $viewModel.backgroundColor)
                .font(.headline)
            
            VStack {
                if let imageData = viewModel.backgroundImageData,
                   let uiImage = UIImage(data: imageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 55, height: 55)
                        .scaledToFit()
                        .cornerRadius(10)
                    
                } else {
                    Rectangle()
                        .frame(width: 55, height: 55)
                        .cornerRadius(10)
                        .foregroundStyle(.secondary.opacity(0.3))
                        .overlay {
                            Image(systemName: "photo")
                                .foregroundStyle(.gray)
                        }
                }
            }
            .padding(.leading, 30)
            .onTapGesture {
                viewModel.qrImageType = .background
                viewModel.isShowPhotoPicker = true
            }
            if viewModel.backgroundImageData  != nil {
                Button(action: {
                    viewModel.backgroundImageData = nil
                }) {
                    Image(systemName: "trash")
                        .foregroundStyle(.red)
                }
            }
            
        }
    }
    
    private var qrLogo: some View {
        HStack {
            Text("Logo")
                .font(.headline)
            Spacer()
            VStack {
                if let imageData = viewModel.logoImageData,
                   let uiImage = UIImage(data: imageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 55, height: 55)
                        .scaledToFit()
                        .cornerRadius(10)
                    
                } else {
                    Rectangle()
                        .frame(width: 55, height: 55)
                        .cornerRadius(10)
                        .foregroundStyle(.secondary.opacity(0.3))
                        .overlay {
                            Image(systemName: "photo")
                                .foregroundStyle(.gray)
                        }
                }
            }
            .padding(.leading, 30)
            .onTapGesture {
                viewModel.qrImageType = .logo
                viewModel.isShowPhotoPicker = true
            }
            if viewModel.logoImageData != nil {
                Button(action: {
                    viewModel.logoImageData = nil
                }) {
                    Image(systemName: "trash")
                        .foregroundStyle(.red)
                }
            }
        }
    }
    
    private var qrTextEditor: some View {
        TextEditor(text: $viewModel.text)
            .frame(height: UIScreen.main.bounds.height / 5.5)
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
            .padding(.vertical, 8)
            .padding(.horizontal)
            .padding(.bottom, viewModel.isEditView
                     ? UIScreen.main.bounds.height / 47
                     : UIScreen.main.bounds.height / 10
            )
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
    
    private var reset: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Reset") { viewModel.reset() }
        }
    }
    
    private var closeButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            if viewModel.isEditView {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                }
            } else {
                qrPicker
            }
        }
    }
}
