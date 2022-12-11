import SwiftUI

struct ButtonView: View {
    let title: String
    let action: () -> ()
    var body: some View {
        Button(action: { withAnimation(.spring()) { action() } }) {
            Text(title)
                .font(.headline)
                .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                .foregroundColor(.textColor)
                .background(Color.buttonColor)
                .cornerRadius(10)
                .shadow(color: .shadowColor, radius: 5, x: 0, y: 0)
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "title", action: {})
    }
}
