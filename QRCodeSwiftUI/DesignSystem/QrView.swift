
import SwiftUI

struct QrView: View {
    let data: Data
    let size: CGFloat
    
    init(data: Data, size: CGFloat = 200) {
        self.data = data
        self.size = size
    }
    
    var body: some View {
        Image(uiImage: UIImage(data: data)!)
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: size, maxHeight: size)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .shadow(radius: 5)
    }
}
