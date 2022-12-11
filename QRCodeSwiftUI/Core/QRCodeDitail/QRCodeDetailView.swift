
import SwiftUI

struct QRCodeDetailView: View {
    let code: QRCode
    var body: some View {
        VStack {
            Spacer()
            codeImage
            Spacer()
            Spacer()
        }
        .navigationTitle(code.name)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                ShareButtonView(codeImageData: code.imageData,imageSize: 20)
            }
        }
    }
    
    private var codeImage: some View {
        Image(uiImage: UIImage(data: code.imageData)!)
            .interpolation(.none)
            .resizable()
            .frame(width: UIScreen.main.bounds.width - 80,
                   height: UIScreen.main.bounds.width - 80)
            .cornerRadius(5)
            .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 0)
    }
    
}

struct QRCodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeDetailView(code: QRCode(name: "name", text: "text", imageData: Data()))
    }
}
