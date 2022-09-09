import SwiftUI

struct SavedCodesView: View {
    @State private var items = ["", "", "", "", "", "", ""]
    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                SavedCodeRowView(item: item)
            }
            .onDelete(perform: deleteItem)
            .onMove(perform: moveItem)
        }
        .navigationTitle("Saved")
        .navigationBarItems(trailing: EditButton())
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
}

struct SavedCodesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCodesView()
    }
}


struct SavedCodeRowView: View {
    let item: String
    var body: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.headline)
            HStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 100, height: 100)
                Text("subtitle")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
