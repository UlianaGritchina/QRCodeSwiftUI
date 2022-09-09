//
//  QRCodeSheetView.swift
//  QRCodeSwiftUI
//
//  Created by Ульяна Гритчина on 09.09.2022.
//

import SwiftUI

struct QRCodeSheetView: View {
    let text: String
    @Binding var isShowingQR: Bool
    private let height = UIScreen.main.bounds.height
    private let width = UIScreen.main.bounds.width
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var body: some View {
        sheet
            .overlay(
                VStack() {
                    grabber.padding(.top)
                    shareButton.padding(.leading, width - 80)
                    codeImage
                    Spacer()
                    saveButton.padding(.bottom, 20)
                }
            )
            .offset(y: isShowingQR ? height / 3.7 : height)
            .ignoresSafeArea()
            .onTapGesture { withAnimation(.spring()) { isShowingQR.toggle() } }
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
        Image(uiImage: generateQRCode(from: text))
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .cornerRadius(5)
            .shadow(radius: 5)
    }
    
}


//MARK: METHODES

extension QRCodeSheetView {
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
}
