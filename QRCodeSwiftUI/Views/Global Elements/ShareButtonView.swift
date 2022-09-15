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
        UIApplication.shared.windows.first?.rootViewController?.present(
            activityVC, animated: true, completion: nil
        )
    }
    
}

struct ShareButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ShareButtonView(codeImageData: Data(), imageSize: 30)
    }
}
