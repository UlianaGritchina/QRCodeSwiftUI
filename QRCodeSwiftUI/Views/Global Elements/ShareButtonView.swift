import SwiftUI

struct ShareButtonView: View {
    let codeImageData: Data
    let imageSize: CGFloat
    var body: some View {
        Button(action: { showShareView() }) {
            Image(systemName: "square.and.arrow.up")
                .font(.system(size: imageSize))
                .frame(alignment: .topTrailing)
        }
    }
    
    private func showShareView() {
        let activityVC = UIActivityViewController(
            activityItems: [codeImageData],
            applicationActivities: nil
        )
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController?.present(
            activityVC, animated: true, completion: nil
        )
    }
    
}

struct ShareButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ShareButtonView(codeImageData: Data(), imageSize: 30)
    }
}
