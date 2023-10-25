import SwiftUI

public struct Example1Alert: View {
    @Binding var isPresented: Bool

    public var body: some View {
        VStack {
            Text("An error has occurred!!")
                .font(.title)

            HStack {
                Button {
                    isPresented = false
                } label: {
                    Text("OK")
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
