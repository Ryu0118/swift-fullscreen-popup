import SwiftUI
import UIKit

extension View {
    func animatableFullScreenCover(
        isPresented: Binding<Bool>,
        duration nanoseconds: UInt64,
        delay: UInt64? = nil,
        content: @escaping () -> some View,
        onAppear: @escaping () -> Void,
        onDisappear: @escaping () -> Void
    ) -> some View {
        modifier(
            AnimatableFullScreenViewModifier(
                isPresented: isPresented,
                duration: nanoseconds,
                delay: delay,
                fullScreenContent: content,
                onAppear: onAppear,
                onDisappear: onDisappear
            )
        )
    }

    func animatableFullScreenCover<Item: Identifiable & Equatable>(
        item: Binding<Item?>,
        duration nanoseconds: UInt64,
        delay: UInt64? = nil,
        content: @escaping (Item) -> some View,
        onAppear: @escaping () -> Void,
        onDisappear: @escaping () -> Void
    ) -> some View {
        modifier(
            AnimatableFullScreenItemViewModifier(
                item: item,
                duration: nanoseconds,
                delay: delay,
                fullScreenContent: content,
                onAppear: onAppear,
                onDisappear: onDisappear
            )
        )
    }
}

private struct AnimatableFullScreenItemViewModifier<FullScreenContent: View, Item: Identifiable & Equatable>: ViewModifier {
    @Binding var isUserInstructToPresentItem: Item?
    @State var isActualPresented: Item?
    @State private var didSuppressAnimation = false

    let nanoseconds: UInt64
    let delay: UInt64?
    let fullScreenContent: (Item) -> (FullScreenContent)
    let onAppear: () -> Void
    let onDisappear: () -> Void

    init(
        item: Binding<Item?>,
        duration nanoseconds: UInt64,
        delay: UInt64?,
        fullScreenContent: @escaping (Item) -> FullScreenContent,
        onAppear: @escaping () -> Void,
        onDisappear: @escaping () -> Void
    ) {
        self._isUserInstructToPresentItem = item
        self.nanoseconds = nanoseconds
        self.delay = delay
        self.fullScreenContent = fullScreenContent
        self.onAppear = onAppear
        self.onDisappear = onDisappear
        self.isActualPresented = item.wrappedValue
    }

    func body(content: Content) -> some View {
        content
            .onChange(of: isUserInstructToPresentItem) { isUserInstructToPresent in
                // `UIView.setAnimationsEnabled` is process-global. When multiple
                // `.popup(item:)` modifiers are stacked on the same view hierarchy,
                // toggling it from an unguarded `onChange` here races with the other
                // instances: one modifier can re-disable it before another instance's
                // `onAppear`/`onDisappear` gets a chance to see it re-enabled, so that
                // instance's completion handler (and the view it presents) never
                // receives the expected callback. Guard with a modifier-local flag so
                // only the instance that actually disabled animations re-enables them.
                didSuppressAnimation = true
                UIView.setAnimationsEnabled(false)
                if isUserInstructToPresent != nil {
                    if let delay {
                        Task {
                            try await Task.sleep(nanoseconds: delay)
                            isActualPresented = isUserInstructToPresent
                        }
                    } else {
                        isActualPresented = isUserInstructToPresent
                    }
                } else {
                    Task {
                        try await Task.sleep(nanoseconds: nanoseconds)
                        isActualPresented = isUserInstructToPresent
                    }
                }
            }
            .fullScreenCover(item: $isActualPresented) { item in
                fullScreenContent(item)
                    .background(BackgroundTransparentView())
                    .onAppear {
                        if didSuppressAnimation {
                            didSuppressAnimation = false
                            UIView.setAnimationsEnabled(true)
                            onAppear()
                        }
                    }
                    .onDisappear {
                        if didSuppressAnimation {
                            didSuppressAnimation = false
                            UIView.setAnimationsEnabled(true)
                            onDisappear()
                        }
                    }
            }
    }
}

private struct AnimatableFullScreenViewModifier<FullScreenContent: View>: ViewModifier {
    @Binding var isUserInstructToPresent: Bool
    @State var isActualPresented: Bool
    @State private var didSuppressAnimation = false

    let nanoseconds: UInt64
    let delay: UInt64?
    let fullScreenContent: () -> (FullScreenContent)
    let onAppear: () -> Void
    let onDisappear: () -> Void

    init(
        isPresented: Binding<Bool>,
        duration nanoseconds: UInt64,
        delay: UInt64?,
        fullScreenContent: @escaping () -> FullScreenContent,
        onAppear: @escaping () -> Void,
        onDisappear: @escaping () -> Void
    ) {
        self._isUserInstructToPresent = isPresented
        self.nanoseconds = nanoseconds
        self.delay = delay
        self.fullScreenContent = fullScreenContent
        self.onAppear = onAppear
        self.onDisappear = onDisappear
        self.isActualPresented = isPresented.wrappedValue
    }

    func body(content: Content) -> some View {
        content
            .onChange(of: isUserInstructToPresent) { isUserInstructToPresent in
                // See the matching comment in `AnimatableFullScreenItemViewModifier`:
                // guard the process-global animation toggle with a modifier-local flag
                // so stacked `.popup` modifiers don't race on `UIView.setAnimationsEnabled`.
                didSuppressAnimation = true
                UIView.setAnimationsEnabled(false)
                if isUserInstructToPresent {
                    if let delay {
                        Task {
                            try await Task.sleep(nanoseconds: delay)
                            isActualPresented = isUserInstructToPresent
                        }
                    } else {
                        isActualPresented = isUserInstructToPresent
                    }
                } else {
                    Task {
                        try await Task.sleep(nanoseconds: nanoseconds)
                        isActualPresented = isUserInstructToPresent
                    }
                }
            }
            .fullScreenCover(isPresented: $isActualPresented) {
                fullScreenContent()
                    .background(BackgroundTransparentView())
                    .onAppear {
                        if didSuppressAnimation {
                            didSuppressAnimation = false
                            UIView.setAnimationsEnabled(true)
                            onAppear()
                        }
                    }
                    .onDisappear {
                        if didSuppressAnimation {
                            didSuppressAnimation = false
                            UIView.setAnimationsEnabled(true)
                            onDisappear()
                        }
                    }
            }
    }
}

private struct BackgroundTransparentView: UIViewRepresentable {
    func makeUIView(context _: Context) -> UIView {
        TransparentView()
    }

    func updateUIView(_: UIView, context _: Context) {}

    private class TransparentView: UIView {
        override func layoutSubviews() {
            super.layoutSubviews()
            superview?.superview?.backgroundColor = .clear
        }
    }
}
