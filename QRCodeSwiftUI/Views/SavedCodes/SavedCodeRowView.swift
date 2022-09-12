
import SwiftUI

struct SavedCodeRowView: View {
    let code: QRCode
    var body: some View {
        VStack {
            NavigationLink {
                QRCodeDetailView(code: code)
            } label: {
                VStack(alignment: .leading) {
                    Text(code.name)
                        .padding(.top)
                        .font(.headline)
                    HStack() {
                        Image(uiImage: UIImage(data: code.imageData)!)
                            .interpolation(.none)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(5)
                            .shadow(color: Color("Color"), radius: 5, x: 0, y: 0)
                        Text(code.text)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(maxHeight: 90)
                    }
                }
            }
        }
    }
}

struct SavedCodeRowView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCodeRowView(code: QRCode(name: "name",
                                      text: "text",
                                      imageData: Data()))
    }
}
