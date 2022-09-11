
import SwiftUI

struct QRCodeDetail: View {
    let code: QRCode
    var body: some View {
        VStack {
            Spacer()
            Image(uiImage: UIImage(data: code.imageData)!)
                .interpolation(.none)
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 80,
                       height: UIScreen.main.bounds.width - 80)
                .cornerRadius(5)
                .shadow(color: Color("Color"), radius: 5, x: 0, y: 0)
            Spacer()
            Spacer()
        }
        .navigationTitle(code.name)
    }
}

struct QRCodeDetail_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeDetail(code: QRCode(name: "name", text: "text", imageData: Data()))
    }
}
