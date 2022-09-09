import SwiftUI

struct QRCodeSheetView: View {
    @StateObject var vm = QRCodeSheetViewViewModel()
    let text: String
    @Binding var isShowingQR: Bool
    private let height = UIScreen.main.bounds.height
    private let width = UIScreen.main.bounds.width
    var body: some View {
        sheet
            .overlay(
                VStack() {
                    grabber.padding(.top)
                    shareButton.padding(.leading, width - 80)
                    codeImage
                    Spacer()
                    saveButton.padding(.bottom, 30)
                }
            )
            .offset(y: isShowingQR ? height / 4.7 : height)
            .offset(y: vm.currentDragOffsetY)
            .offset(y: vm.endingOffsetY)
            .ignoresSafeArea()
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.spring()) {
                            vm.currentDragOffsetY = value.translation.height
                        }
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            if vm.currentDragOffsetY > 10 {
                                isShowingQR.toggle()
                            }
                            vm.currentDragOffsetY = 0
                        }
                    }
            )
    }
}

struct QRCodeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeSheetView(text: "", isShowingQR: .constant(true))
    }
}


//MARK: ELEMENTS

extension QRCodeSheetView {
    
    private var sheet: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height / 2.2)
            .foregroundColor(.white)
    }
    
    private var grabber: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 40, height: 5)
            .opacity(0.2)
    }
    
    private var shareButton: some View {
        Button(action: {}) {
            Image(systemName: "square.and.arrow.up")
                .font(.system(size: height / 35))
                .frame(alignment: .topTrailing)
        }
    }
    
    private var saveButton: some View {
        Button(action: {}) {
            Text("Save")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 80,
                       height: 45)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
    
    private var codeImage: some View {
        Image(uiImage: vm.generateQRCode(from: text))
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .cornerRadius(5)
            .shadow(radius: 5)
    }
    
}
