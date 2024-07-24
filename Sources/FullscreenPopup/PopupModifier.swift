import SwiftUI

struct PopupModifier<Popup: View, Background: View>: ViewModifier {
    @Binding var isUserInstructToPresent: Bool
    @State var isViewAppeared: Bool = false

    var presentationAnimationTrigger: Bool {
        isUserInstructToPresent ? isViewAppeared : false
    }

    let animation: Animation
    let duration: UInt64
    let delay: UInt64?
    let popup: (Bool) -> Popup
    let background: (Bool) -> Background

    init(
        isPresented: Binding<Bool>,
        duration nanoseconds: UInt64,
        delay: UInt64? = nil,
        animation: Animation,
        @ViewBuilder popup: @escaping (_ isPresented: Bool) -> Popup,
        @ViewBuilder background: @escaping (_ isPresented: Bool) -> Background
    ) {
        self._isUserInstructToPresent = isPresented
        self.duration = nanoseconds
        self.delay = delay
        self.animation = animation
        self.popup = popup
        self.background = background
    }

    func body(content: Content) -> some View {
        content.animatableFullScreenCover(
            isPresented: $isUserInstructToPresent,
            duration: duration,
            delay: delay
        ) {
            popup(presentationAnimationTrigger)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .scaleEffect(presentationAnimationTrigger ? 1 : 0)
                .background(
                    background(presentationAnimationTrigger)
                        .ignoresSafeArea()
                )
                .animation(animation, value: presentationAnimationTrigger)
        } onAppear: {
            isViewAppeared = isUserInstructToPresent
        } onDisappear: {
            isViewAppeared = isUserInstructToPresent
        }
    }
}
