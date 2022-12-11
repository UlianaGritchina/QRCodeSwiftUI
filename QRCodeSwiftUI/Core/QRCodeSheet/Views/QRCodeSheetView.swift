import SwiftUI

struct QRCodeSheetView: View {
    @EnvironmentObject var savedCodesViewModel: SavedCodesViewViewModel
    @ObservedObject var vm: QRCodeSheetViewModel
    @Binding var isShowingQR: Bool
    
    private let height = UIScreen.main.bounds.height
    private let width = UIScreen.main.bounds.width
    var body: some View {
        ZStack {
            helloFriendView
            sheet
        }
    }
}

struct QRCodeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeSheetView(
            vm: QRCodeSheetViewModel(
                text: "text",
                color1: .black,
                color2: .white
            ),
            isShowingQR: .constant(true)
        )
    }
}


//MARK: ELEMENTS

extension QRCodeSheetView {
    
    private var sheet: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: width, height: height / 2.2)
            .foregroundColor(.sheetColor)
            .overlay(qrCodeContent)
            .offset(y: isShowingQR ? height / 4.7 : height)
            .offset(y: vm.currentDragOffsetY)
            .offset(y: vm.endingOffsetY)
            .ignoresSafeArea()
            .gesture(
                DragGesture()
                    .onChanged { value in startDrag(value) }
                    .onEnded { value in stopDrag() }
            )
    }
    
    private var qrCodeContent: some View {
        VStack() {
            grabber.padding(.top)
            ShareButtonView(
                codeImageData: vm.qrImageData,
                imageSize: height / 35
            )
            .padding(.leading, width - 80)
            if vm.isGoingToSave { nameTF }
            codeImage
            Spacer()
            
            ButtonView(title: "Save", action: saveQR).padding(.bottom, 40)
        }
    }
    
    private var helloFriendView: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: width, height: height / 2.2)
            .offset(y: isShowingQR ? height / 4.7 : height)
            .overlay(
                VStack {
                    Spacer()
                    Text("Hello Friend")
                        .foregroundColor(Color("text"))
                        .font(.system(size: height / 30))
                }
            )
            .opacity(vm.helloFriendOpacity)
        
    }
    
    private var grabber: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 40, height: 5)
            .opacity(0.5)
            .foregroundColor(.grabberColor)
    }
    
    private var codeImage: some View {
        QrView(data: vm.qrImageData)
    }
    
    private var nameTF: some View {
        TextField("Give a name", text: $vm.name)
            .font(.headline)
            .multilineTextAlignment(.center)
    }
    
}


//MARK: METHODES

extension QRCodeSheetView {
    
    private func startDrag(_ value: DragGesture.Value) {
        withAnimation(.spring()) {
            vm.currentDragOffsetY = value.translation.height
            if vm.currentDragOffsetY < 0 {
                vm.helloFriendOpacity = 1
            }
            if vm.currentDragOffsetY >= 0 {
                vm.helloFriendOpacity = 0
            }
        }
    }
    
    private func stopDrag() {
        withAnimation(.spring()) {
            if vm.currentDragOffsetY > 10 {
                isShowingQR.toggle()
            }
            vm.helloFriendOpacity = 0
            vm.currentDragOffsetY = 0
        }
    }
    
    private func saveQR() {
        withAnimation {
            vm.isGoingToSave.toggle()
            if !vm.isGoingToSave {
                vm.isGoingToSave.toggle()
                savedCodesViewModel.addQR(name: vm.name,
                                          text: vm.text,
                                          imageData: vm.qrImageData)
                isShowingQR.toggle()
                vm.name = ""
            }
        }
        if !isShowingQR { vm.isGoingToSave.toggle() }
    }
    
}
