import SwiftUI

struct ShareButtonView: View {
    let codeImageData: Data
    let imageSize: CGFloat
    var body: some View {
        if #available(iOS 16.0, *) {
            ShareLink(
                item: Image(uiImage: UIImage(data: codeImageData)!),
                preview: SharePreview(
                    "QR-code",
                    image: Image(uiImage: UIImage(data: codeImageData)!))) {
                        Image(systemName: "square.and.arrow.up").font(.system(size: imageSize))
                    }
        } else {
            Button(action: { showShareView() }) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: imageSize))
            }
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
        let vc = window?.rootViewController
        activityVC.popoverPresentationController?.sourceView = vc?.view
        activityVC.popoverPresentationController?.sourceRect = .zero
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
