import SwiftUI

struct QRCodeImageView: View {
    let width =  UIScreen.main.bounds.width
    let imageData: Data
    var body: some View {
        Image(uiImage: (UIImage(data: imageData) ?? UIImage(named: "defaultQRImage"))!)
            .interpolation(.none)
            .resizable()
            .frame(width: 200, height: 200)
            .cornerRadius(5)
            .shadow(color: .shadowColor, radius: 5, x: 0, y: 0)
    }
}

struct QRCodeImageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QRCodeImageView(imageData: Data())
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
            
            QRCodeImageView(imageData: Data())
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
            
        }
    }
}
