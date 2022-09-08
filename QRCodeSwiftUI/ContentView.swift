import SwiftUI
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var string = ""
    @State private var isShowingQR = false
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var body: some View {
        NavigationView {
            VStack() {
                Text("Link, email, some text")
                    .font(.headline)
                    .foregroundColor(.gray)
                textEditor
                
                Spacer()
                code
                Spacer()
                generateButton
            }
            .navigationTitle("QR")
            .padding()
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    
    private var textEditor: some View {
        TextEditor(text: $string)
            .font(.headline)
            .multilineTextAlignment(.leading)
            .frame(width: UIScreen.main.bounds.width - 40,
                   height: UIScreen.main.bounds.height / 3)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
            .ignoresSafeArea(.keyboard, edges: .all)
    }
    
    private var generateButton: some View {
        Button(action: {}) {
            Text("Generate")
                .font(.headline)
                .frame(width: UIScreen.main.bounds.width - 80,
                       height: 45)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
    
    private var code: some View {
        Image(uiImage: generateQRCode(from: string))
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .cornerRadius(5)
            .shadow(radius: 5)
    }
    
}
