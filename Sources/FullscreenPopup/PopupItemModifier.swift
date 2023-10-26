import SwiftUI

struct PopupItemModifier<Popup: View, Background: View, Item: Identifiable & Equatable>: ViewModifier {
    @Binding var isUserInstructToPresent: Item?
    @Binding var item: Item?
    @State var isViewAppeared: Bool = false

    var presentationAnimationTrigger: Bool {
        isUserInstructToPresent != nil ? isViewAppeared : false
    }

    let animation: Animation
    let duration: UInt64
    let popup: (Item) -> Popup
    let background: (Bool) -> Background

    init(
        item: Binding<Item?>,
        duration nanoseconds: UInt64,
        animation: Animation,
        @ViewBuilder popup: @escaping (_ item: Item) -> Popup,
        @ViewBuilder background: @escaping (_ isPresented: Bool) -> Background
    ) {

        self._isUserInstructToPresent = item
        self._item = item
        self.duration = nanoseconds
        self.animation = animation
        self.popup = popup
        self.background = background
    }

    func body(content: Content) -> some View {
        content.animatableFullScreenCover(
            item: $isUserInstructToPresent,
            duration: duration
        ) { item in
            popup(item)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .scaleEffect(presentationAnimationTrigger ? 1 : 0)
                .background(
                    background(presentationAnimationTrigger)
                        .ignoresSafeArea()
                )
                .animation(animation, value: presentationAnimationTrigger)
        } onAppear: {
            isViewAppeared = true
        } onDisappear: {
            isViewAppeared = false
        }
    }
}
