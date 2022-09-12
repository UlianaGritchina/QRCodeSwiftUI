import SwiftUI

struct ShareButtonView: View {
    let codeImageData: Data
    var body: some View {
        Button(action: {
            showShareView()
        }) {
            Image(systemName: "square.and.arrow.up")
                .font(.system(size: UIScreen.main.bounds.height / 35))
                .frame(alignment: .topTrailing)
        }
    }
    
    private func showShareView() {
        let activityVC = UIActivityViewController(
            activityItems: [codeImageData],
            applicationActivities: nil
        )
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
    
}

struct ShareButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ShareButtonView(codeImageData: Data())
    }
}
