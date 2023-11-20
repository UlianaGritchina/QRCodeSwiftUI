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
                    qrTitleView
                    header
                    textEditor
                    colorPickers
                }
                .padding()
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
        GenerateQRView(editingQR: .constant(QRCode()))
    }
}

//MARK: ELEMENTS

extension GenerateQRView {
    
    private var header: some View {
        Text("Link, email, some text")
            .font(.headline)
            .foregroundColor(.gray)
    }
    
    @ViewBuilder private var qrTitleView: some View {
        if viewModel.isEditView {
            TextField("title", text: $viewModel.qrTitle)
                .font(.system(
                    size: 20,
                    weight: .regular, design: .rounded
                ))
                .padding(10)
                .background(.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom)
                .frame(maxWidth: 700)
            
        }
    }
    
    private var textEditor: some View {
        TextEditor(text: $viewModel.content)
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
    
}
