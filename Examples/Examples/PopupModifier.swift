import SwiftUI

public struct SimplePopupModifier<Popup: View>: ViewModifier {
    @Binding var isPresented: Bool
    @ViewBuilder var popup: () -> Popup

    public func body(content: Content) -> some View {
        ZStack {
            content
            Color.black
                .opacity(isPresented ? 0.5 : 0)
                .ignoresSafeArea()
            popup()
                .scaleEffect(isPresented ? 1 : 0)
        }
    }
}
