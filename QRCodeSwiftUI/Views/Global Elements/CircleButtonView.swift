
import SwiftUI

struct CircleButtonView: View {
    let imageName: String
    let action: () -> ()
    var body: some View {
        Button(action: action) {
            Circle()
                .frame(width: UIScreen.main.bounds.width / 7)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.2),
                        radius: 5, x: 0, y: 0)
                .blur(radius: 0.5)
                .overlay {
                    Image(imageName)
                        .resizable()
                        .frame(width: 30, height: 30)
                }
        }
    }
}
struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonView(imageName: "heart", action: {})
    }
}
