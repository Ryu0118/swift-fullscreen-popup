import SwiftUI
import FullscreenPopup

struct ContentView: View {
    @State var isExample1Presented = false
    @State var isExample2Presented = false
    @State var example3Item: MyItem?

    var body: some View {
        Color.white
            .sheet(isPresented: .constant(true)) {
                NavigationStack {
                    Form {
                        Button {
                            isExample1Presented = true
                        } label: {
                            Text("Show Alert 1")
                        }

                        Button {
                            isExample2Presented = true
                        } label: {
                            Text("Show Alert 2")
                        }

                        Button {
                            example3Item = .init(id: UUID())
                        } label: {
                            Text("Show Alert 3")
                        }
                    }
                    .navigationTitle("Title")
                    .toolbarTitleDisplayMode(.inline)
                    .popup(isPresented: $isExample1Presented) {
                        Example1Alert(isPresented: $isExample1Presented)
                    }
                    .popup(item: $example3Item) { item in
                        VStack {
                            Text(item.id.uuidString)
                            Button {
                                example3Item = nil
                            } label: {
                                Text("Close")
                            }
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .modifier(SimplePopupModifier(isPresented: $isExample2Presented) {
                        Example1Alert(isPresented: $isExample2Presented)
                    })
                }
            }
    }
}

struct MyItem: Identifiable, Equatable {
    let id: UUID
}

#Preview {
    ContentView()
}
