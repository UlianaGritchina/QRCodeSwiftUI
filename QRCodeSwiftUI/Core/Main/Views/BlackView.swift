import SwiftUI

struct BlackView: View {
    let opacity: Double
    var body: some View {
        Rectangle()
            .ignoresSafeArea()
            .foregroundColor(.black)
            .opacity(opacity)
    }
}

struct BlackView_Previews: PreviewProvider {
    static var previews: some View {
        BlackView(opacity: 0.5)
    }
}
