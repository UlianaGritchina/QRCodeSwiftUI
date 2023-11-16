
import SwiftUI

struct SavedCodeRowView: View {
    let code: QRCode
    var body: some View {
        VStack {
            NavigationLink {
                QRCodeDetailView(qrCode: code)
            } label: {
                VStack(alignment: .leading) {
                    qrCodeName
                    HStack(alignment: .top) {
                        qrCodeImage
                        qrCodeData
                        Spacer()
                    }
                }
            }
        }
        .padding()
        .background(Color("cardBackground"))
        .cornerRadius(10)
        .shadow(color: Color("shadow").opacity(0.5), radius: 5, x: 3, y: 5)
    }
}

struct SavedCodeRowView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCodeRowView(
            code: QRCode(
                name: "name",
                text: "text",
                imageData: (UIImage(named: "defaultQRImage")?.pngData())!,
                dateCreated: Date()
            )
        )
    }
}

extension SavedCodeRowView {
    
    private var qrCodeName: some View {
        Text(code.name)
            .font(.headline)
    }
    
    private var qrCodeImage: some View {
        Image(uiImage: UIImage(data: code.imageData)!)
            .interpolation(.none)
            .resizable()
            .frame(width: 100, height: 100)
            .cornerRadius(5)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
    }
    
    private var qrCodeData: some View {
        Text(code.text)
            .font(.subheadline)
            .foregroundColor(.gray)
            .multilineTextAlignment(.leading)
    }
    
}
