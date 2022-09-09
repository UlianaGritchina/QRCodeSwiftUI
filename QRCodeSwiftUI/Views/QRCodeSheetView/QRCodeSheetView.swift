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
        Group {
            QRCodeSheetView(text: "", isShowingQR: .constant(true))
            QRCodeSheetView(text: "", isShowingQR: .constant(true)).preferredColorScheme(.dark)
        }
    }
}


//MARK: ELEMENTS

extension QRCodeSheetView {
    
    private var sheet: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height / 2.2)
            .foregroundColor(Color("text"))
            //.shadow(color: Color("Color"), radius: 5, x: 0, y: 0)
    }
    
    private var grabber: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 40, height: 5)
            .opacity(0.5)
            .foregroundColor(Color("grabber"))
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
                .foregroundColor(Color("text"))
                .frame(width: UIScreen.main.bounds.width - 80,
                       height: 50)
                .background(Color("Button"))
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
            .shadow(color: Color("Color"), radius: 5, x: 0, y: 0)
    }
    
}
