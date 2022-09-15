import SwiftUI

struct QRCodeSheetView: View {
    @EnvironmentObject var savedCodesViewModel: SavedCodesViewViewModel
    @ObservedObject var vm: QRCodeSheetViewViewModel
    @Binding var isShowingQR: Bool
    @State private var op: Double = 0
    private let height = UIScreen.main.bounds.height
    private let width = UIScreen.main.bounds.width
    var body: some View {
        
        RoundedRectangle(cornerRadius: 15)
            .frame(width: width, height: height / 2.2)
            .offset(y: isShowingQR ? height / 4.7 : height)
            .opacity(op)
            .overlay(
                
                ZStack {
                    
                    VStack {
                        Spacer()
                        Text("Hello Friend")
                            .foregroundColor(Color("text"))
                            .font(.system(size: height / 30))
                            .opacity(op)
                        
                    }
                    sheet
                        .overlay(
                            VStack() {
                                grabber.padding(.top)
                                ShareButtonView(
                                    codeImageData: vm.qrImageData,
                                    imageSize: height / 30
                                )
                                    .padding(.leading, width - 80)
                                if vm.isGoingToSave { nameTF }
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
                                        if vm.currentDragOffsetY < 0 {
                                            op = 1
                                        }
                                        if vm.currentDragOffsetY >= 0 {
                                            op = 0
                                        }
                                    }
                                }
                                .onEnded { value in
                                    withAnimation(.spring()) {
                                        if vm.currentDragOffsetY > 10 {
                                            isShowingQR.toggle()
                                            
                                        }
                                        
                                        op = 0
                                        
                                        vm.currentDragOffsetY = 0
                                    }
                                }
                        )
                }
                
                
            )
        
        
        
    }
}

struct QRCodeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeSheetView(
            vm: QRCodeSheetViewViewModel(
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
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height / 2.2)
            .foregroundColor(Color("text"))
    }
    
    private var grabber: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 40, height: 5)
            .opacity(0.5)
            .foregroundColor(Color("grabber"))
    }
    
    private var shareButton: some View {
        Button(action: {
            let activityVC = UIActivityViewController(
                activityItems: [vm.qrImageData],
                applicationActivities: nil
            )
            UIApplication.shared.windows.first?.rootViewController?.present(
                activityVC, animated: true, completion: nil
            )
            
        }) {
            Image(systemName: "square.and.arrow.up")
                .font(.system(size: height / 35))
                .frame(alignment: .topTrailing)
        }
    }
    
    private var saveButton: some View {
        Button(action: saveQR) {
            Text("Save")
                .font(.headline)
                .foregroundColor(Color("text"))
                .frame(width: width - 80,  height: 50)
                .background(Color("Button"))
                .cornerRadius(10)
        }
    }
    
    private var codeImage: some View {
        Image(uiImage: UIImage(data: vm.qrImageData)!)
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .cornerRadius(5)
            .shadow(color: Color("Color"), radius: 5, x: 0, y: 0)
    }
    
    private var nameTF: some View {
        TextField("Give a name", text: $vm.name)
            .font(.headline)
            .multilineTextAlignment(.center)
    }
    
}


//MARK: METHODES

extension QRCodeSheetView {
    
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
