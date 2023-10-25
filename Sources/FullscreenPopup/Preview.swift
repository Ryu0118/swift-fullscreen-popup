import SwiftUI

private struct TestView: View {
    @State var isPopupPresented = false
    var body: some View {
        Button {
            isPopupPresented = true
        } label: {
            Text("ボタンを押してください")
        }
        .popup(isPresented: $isPopupPresented) {
            VStack {
                Text("ほげ")
                Button {
                    self.isPopupPresented = false
                } label: {
                    Text("閉じる")
                }
            }
            .padding(100)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}

#Preview {
    TestView()
}
