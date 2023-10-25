import SwiftUI
import FullscreenPopup

struct ContentView: View {
    @State var isExample1Presented = false
    @State var isExample2Presented = false

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
                    }
                    .navigationTitle("Title")
                    .toolbarTitleDisplayMode(.inline)
                    .popup(isPresented: $isExample1Presented) {
                        Example1Alert(isPresented: $isExample1Presented)
                    }
                    .modifier(SimplePopupModifier(isPresented: $isExample2Presented) {
                        Example1Alert(isPresented: $isExample2Presented)
                    })
                }
            }
    }
}

#Preview {
    ContentView()
}
