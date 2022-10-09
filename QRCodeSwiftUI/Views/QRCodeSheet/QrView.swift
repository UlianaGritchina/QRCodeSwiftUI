import SwiftUI

struct QrView: View {
    let data: Data
    var body: some View {
        Image(uiImage: UIImage(data: data)!)
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .cornerRadius(5)
            .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 0)
    }
}

struct QrView_Previews: PreviewProvider {
    static var previews: some View {
        QrView(data: Data())
    }
}
