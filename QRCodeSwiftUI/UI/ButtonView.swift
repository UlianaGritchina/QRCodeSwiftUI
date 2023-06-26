import SwiftUI

struct ButtonView: View {
    let title: String
    let action: () -> ()
    var body: some View {
        Button(action:  action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .foregroundColor(.textColor)
                .background(Color.accentColor)
                .cornerRadius(10)
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "title", action: {})
    }
}
