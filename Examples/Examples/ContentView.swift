import SwiftUI
import FullscreenPopup

struct ContentView: View {
    @State var isExample1Presented = false
    @State var isExample2Presented = false
    @State var isExample3Presented = false
    @State var example4Item: MyItem?

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
                            isExample3Presented = true
                        } label: {
                            Text("Show Delay Alert 3")
                        }

                        Button {
                            example4Item = .init(id: UUID())
                        } label: {
                            Text("Show Alert 4")
                        }
                    }
                    .navigationTitle("Title")
                    .toolbarTitleDisplayMode(.inline)
                    .popup(isPresented: $isExample1Presented) {
                        Example1Alert(isPresented: $isExample1Presented)
                    }
                    .popup(isPresented: $isExample3Presented, delay: .seconds(1)) {
                        Example1Alert(isPresented: $isExample3Presented)
                    }
                    .popup(item: $example4Item) { item in
                        VStack {
                            Text(item.id.uuidString)
                            Button {
                                example4Item = nil
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
