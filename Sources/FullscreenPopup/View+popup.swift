import SwiftUI

public extension View {
    /// Presents a popup with customizable content and background. Available from macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0.
    ///
    /// - Note: The `duration` parameter must be greater than the `duration` of the `animation`.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the popup.
    ///   - duration: The duration of the popup animation. Default is 0.35 seconds.
    ///               Ensure this duration is longer than the animation's duration.
    ///   - animation: The animation to use when presenting the popup. Default is a spring animation.
    ///   - popup: A closure returning the popup content. The closure takes a Boolean indicating the presentation state.
    ///   - background: A closure returning the background content. The closure takes a Boolean indicating the presentation state.
    /// - Returns: A view with the popup applied.
    @available(iOS 16.0, *)
    func popup<Popup: View, Background: View>(
        isPresented: Binding<Bool>,
        duration: Duration = .seconds(0.35),
        animation: Animation = .spring(duration: 0.3, bounce: 0.25, blendDuration: 0.1),
        @ViewBuilder background: @escaping (_ isPresented: Bool) -> Background = { Color.black.opacity($0 ? 0.5 : 0) },
        @ViewBuilder content: @escaping (_ isPresented: Bool) -> Popup
    ) -> some View {
        modifier(
            PopupModifier(
                isPresented: isPresented,
                duration: duration.nanoseconds,
                animation: animation,
                popup: content,
                background: background
            )
        )
    }

    /// Presents a popup with customizable content and background. Available from macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0.
    ///
    /// - Note: The `duration` parameter must be greater than the `duration` of the `animation`.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the popup.
    ///   - duration: The duration of the popup animation. Default is 0.35 seconds.
    ///               Ensure this duration is longer than the animation's duration.
    ///   - delay: The amount of time to wait before beginning the animations. Specify a value of 0 to begin the animations immediately.
    ///   - animation: The animation to use when presenting the popup. Default is a spring animation.
    ///   - popup: A closure returning the popup content. The closure takes a Boolean indicating the presentation state.
    ///   - background: A closure returning the background content. The closure takes a Boolean indicating the presentation state.
    /// - Returns: A view with the popup applied.
    @available(iOS 16.0, *)
    func popup<Popup: View, Background: View>(
        isPresented: Binding<Bool>,
        duration: Duration = .seconds(0.35),
        delay: Duration,
        animation: Animation = .spring(duration: 0.3, bounce: 0.25, blendDuration: 0.1),
        @ViewBuilder background: @escaping (_ isPresented: Bool) -> Background = { Color.black.opacity($0 ? 0.5 : 0) },
        @ViewBuilder content: @escaping (_ isPresented: Bool) -> Popup
    ) -> some View {
        modifier(
            PopupModifier(
                isPresented: isPresented,
                duration: duration.nanoseconds,
                delay: delay.nanoseconds,
                animation: animation,
                popup: content,
                background: background
            )
        )
    }

    /// Presents a popup with customizable content and background. Available from macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0.
    ///
    /// - Note: The `duration` parameter must be greater than the `duration` of the `animation`.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the popup.
    ///   - duration: The duration of the popup animation. Default is 0.35 seconds.
    ///               Ensure this duration is longer than the animation's duration.
    ///   - animation: The animation to use when presenting the popup. Default is a spring animation.
    ///   - popup: A closure returning the popup content.
    ///   - background: A closure returning the background content. The closure takes a Boolean indicating the presentation state.
    /// - Returns: A view with the popup applied.
    @available(iOS 16.0, *)
    func popup<Popup: View, Background: View>(
        isPresented: Binding<Bool>,
        duration: Duration = .seconds(0.35),
        animation: Animation = .spring(duration: 0.3, bounce: 0.25, blendDuration: 0.1),
        @ViewBuilder background: @escaping (_ isPresented: Bool) -> Background = { Color.black.opacity($0 ? 0.5 : 0) },
        @ViewBuilder content: @escaping () -> Popup
    ) -> some View {
        modifier(
            PopupModifier(
                isPresented: isPresented,
                duration: duration.nanoseconds,
                animation: animation,
                popup: { _ in content() },
                background: background
            )
        )
    }

    /// Presents a popup with customizable content and background. Available from macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0.
    ///
    /// - Note: The `duration` parameter must be greater than the `duration` of the `animation`.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the popup.
    ///   - duration: The duration of the popup animation. Default is 0.35 seconds.
    ///               Ensure this duration is longer than the animation's duration.
    ///   - delay: The amount of time to wait before beginning the animations. Specify a value of 0 to begin the animations immediately.
    ///   - animation: The animation to use when presenting the popup. Default is a spring animation.
    ///   - popup: A closure returning the popup content.
    ///   - background: A closure returning the background content. The closure takes a Boolean indicating the presentation state.
    /// - Returns: A view with the popup applied.
    @available(iOS 16.0, *)
    func popup<Popup: View, Background: View>(
        isPresented: Binding<Bool>,
        duration: Duration = .seconds(0.35),
        delay: Duration,
        animation: Animation = .spring(duration: 0.3, bounce: 0.25, blendDuration: 0.1),
        @ViewBuilder background: @escaping (_ isPresented: Bool) -> Background = { Color.black.opacity($0 ? 0.5 : 0) },
        @ViewBuilder content: @escaping () -> Popup
    ) -> some View {
        modifier(
            PopupModifier(
                isPresented: isPresented,
                duration: duration.nanoseconds,
                delay: delay.nanoseconds,
                animation: animation,
                popup: { _ in content() },
                background: background
            )
        )
    }

    /// Presents a popup with customizable content and background.
    ///
    /// - Note: The `duration` parameter must be greater than the `duration` of the `animation`.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the popup.
    ///   - duration: The duration of the popup animation in nanoseconds. Default is 350,000,000 nanoseconds.
    ///                  Ensure this duration is longer than the animation's duration.
    ///   - animation: The animation to use when presenting the popup. Default is a spring animation.
    ///   - popup: A closure returning the popup content. The closure takes a Boolean indicating the presentation state.
    ///   - background: A closure returning the background content. The closure takes a Boolean indicating the presentation state.
    /// - Returns: A view with the popup applied.
    @_disfavoredOverload
    func popup<Popup: View, Background: View>(
        isPresented: Binding<Bool>,
        duration nanoseconds: UInt64 = 350_000_000,
        animation: Animation = .spring(duration: 0.3, bounce: 0.25, blendDuration: 0.1),
        @ViewBuilder background: @escaping (_ isPresented: Bool) -> Background = { Color.black.opacity($0 ? 0.5 : 0) },
        @ViewBuilder content: @escaping (_ isPresented: Bool) -> Popup
    ) -> some View {
        modifier(
            PopupModifier(
                isPresented: isPresented,
                duration: nanoseconds,
                animation: animation,
                popup: content,
                background: background
            )
        )
    }

    /// Presents a popup with customizable content and background.
    ///
    /// - Note: The `duration` parameter must be greater than the `duration` of the `animation`.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the popup.
    ///   - duration: The duration of the popup animation in nanoseconds. Default is 350,000,000 nanoseconds.
    ///                  Ensure this duration is longer than the animation's duration.
    ///   - delay: The amount of time (measured in nanoseconds) to wait before beginning the animations. Specify a value of 0 to begin the animations immediately.
    ///   - animation: The animation to use when presenting the popup. Default is a spring animation.
    ///   - popup: A closure returning the popup content. The closure takes a Boolean indicating the presentation state.
    ///   - background: A closure returning the background content. The closure takes a Boolean indicating the presentation state.
    /// - Returns: A view with the popup applied.
    @_disfavoredOverload
    func popup<Popup: View, Background: View>(
        isPresented: Binding<Bool>,
        duration nanoseconds: UInt64 = 350_000_000,
        delay: UInt64,
        animation: Animation = .spring(duration: 0.3, bounce: 0.25, blendDuration: 0.1),
        @ViewBuilder background: @escaping (_ isPresented: Bool) -> Background = { Color.black.opacity($0 ? 0.5 : 0) },
        @ViewBuilder content: @escaping (_ isPresented: Bool) -> Popup
    ) -> some View {
        modifier(
            PopupModifier(
                isPresented: isPresented,
                duration: nanoseconds,
                delay: delay,
                animation: animation,
                popup: content,
                background: background
            )
        )
    }


    /// Presents a popup with customizable content and background.
    ///
    /// - Note: The `duration` parameter must be greater than the `duration` of the `animation`.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the popup.
    ///   - duration: The duration of the popup animation in nanoseconds. Default is 350,000,000 nanoseconds.
    ///                  Ensure this duration is longer than the animation's duration.
    ///   - animation: The animation to use when presenting the popup. Default is a spring animation.
    ///   - popup: A closure returning the popup content.
    ///   - background: A closure returning the background content. The closure takes a Boolean indicating the presentation state.
    /// - Returns: A view with the popup applied.
    @_disfavoredOverload
    func popup<Popup: View, Background: View>(
        isPresented: Binding<Bool>,
        duration nanoseconds: UInt64 = 350_000_000,
        animation: Animation = .spring(duration: 0.3, bounce: 0.25, blendDuration: 0.1),
        @ViewBuilder background: @escaping (_ isPresented: Bool) -> Background = { Color.black.opacity($0 ? 0.5 : 0) },
        @ViewBuilder content: @escaping () -> Popup
    ) -> some View {
        modifier(
            PopupModifier(
                isPresented: isPresented,
                duration: nanoseconds,
                animation: animation,
                popup: { _ in content() },
                background: background
            )
        )
    }

    /// Presents a popup with customizable content and background.
    ///
    /// - Note: The `duration` parameter must be greater than the `duration` of the `animation`.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the popup.
    ///   - duration: The duration of the popup animation in nanoseconds. Default is 350,000,000 nanoseconds.
    ///                  Ensure this duration is longer than the animation's duration.
    ///   - delay: The amount of time (measured in nanoseconds) to wait before beginning the animations. Specify a value of 0 to begin the animations immediately.
    ///   - animation: The animation to use when presenting the popup. Default is a spring animation.
    ///   - popup: A closure returning the popup content.
    ///   - background: A closure returning the background content. The closure takes a Boolean indicating the presentation state.
    /// - Returns: A view with the popup applied.
    @_disfavoredOverload
    func popup<Popup: View, Background: View>(
        isPresented: Binding<Bool>,
        duration nanoseconds: UInt64 = 350_000_000,
        delay: UInt64,
        animation: Animation = .spring(duration: 0.3, bounce: 0.25, blendDuration: 0.1),
        @ViewBuilder background: @escaping (_ isPresented: Bool) -> Background = { Color.black.opacity($0 ? 0.5 : 0) },
        @ViewBuilder content: @escaping () -> Popup
    ) -> some View {
        modifier(
            PopupModifier(
                isPresented: isPresented,
                duration: nanoseconds,
                delay: delay,
                animation: animation,
                popup: { _ in content() },
                background: background
            )
        )
    }
}

public extension View {
    /// Presents a popup with customizable content and background based on an identifiable item. Available from macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0.
    ///
    /// - Note: The `duration` parameter must be greater than the `duration` of the `animation`.
    ///
    /// - Parameters:
    ///   - item: A binding to an optional identifiable item that determines whether to present the popup. The popup is presented if the item is non-nil.
    ///   - duration: The duration of the popup animation. Default is 0.35 seconds.
    ///               Ensure this duration is longer than the animation's duration.
    ///   - animation: The animation to use when presenting the popup. Default is a spring animation.
    ///   - background: A closure returning the background content. The closure takes a Boolean indicating the presentation state.
    ///   - content: A closure returning the popup content. The closure takes the current item as a parameter.
    /// - Returns: A view with the popup applied.
    @available(iOS 16.0, *)
    func popup<Popup: View, Background: View, Item: Identifiable & Equatable>(
        item: Binding<Item?>,
        duration: Duration = .seconds(0.35),
        animation: Animation = .spring(duration: 0.3, bounce: 0.25, blendDuration: 0.1),
        @ViewBuilder background: @escaping (_ isPresented: Bool) -> Background = { Color.black.opacity($0 ? 0.5 : 0) },
        @ViewBuilder content: @escaping (_ item: Item) -> Popup
    ) -> some View {
        modifier(
            PopupItemModifier(
                item: item,
                duration: duration.nanoseconds,
                animation: animation,
                popup: content,
                background: background
            )
        )
    }

    /// Presents a popup with customizable content and background based on an identifiable item. Available from macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0.
    ///
    /// - Note: The `duration` parameter must be greater than the `duration` of the `animation`.
    ///
    /// - Parameters:
    ///   - item: A binding to an optional identifiable item that determines whether to present the popup. The popup is presented if the item is non-nil.
    ///   - duration: The duration of the popup animation. Default is 0.35 seconds.
    ///               Ensure this duration is longer than the animation's duration.
    ///   - delay: The amount of time to wait before beginning the animations. Specify a value of 0 to begin the animations immediately.
    ///   - animation: The animation to use when presenting the popup. Default is a spring animation.
    ///   - background: A closure returning the background content. The closure takes a Boolean indicating the presentation state.
    ///   - content: A closure returning the popup content. The closure takes the current item as a parameter.
    /// - Returns: A view with the popup applied.
    @available(iOS 16.0, *)
    func popup<Popup: View, Background: View, Item: Identifiable & Equatable>(
        item: Binding<Item?>,
        duration: Duration = .seconds(0.35),
        delay: Duration,
        animation: Animation = .spring(duration: 0.3, bounce: 0.25, blendDuration: 0.1),
        @ViewBuilder background: @escaping (_ isPresented: Bool) -> Background = { Color.black.opacity($0 ? 0.5 : 0) },
        @ViewBuilder content: @escaping (_ item: Item) -> Popup
    ) -> some View {
        modifier(
            PopupItemModifier(
                item: item,
                duration: duration.nanoseconds,
                delay: delay.nanoseconds,
                animation: animation,
                popup: content,
                background: background
            )
        )
    }

    /// Presents a popup with customizable content and background based on an identifiable item.
    ///
    /// - Note: The `duration` parameter must be greater than the `duration` of the `animation`.
    ///
    /// - Parameters:
    ///   - item: A binding to an optional identifiable item that determines whether to present the popup. The popup is presented if the item is non-nil.
    ///   - duration: The duration of the popup animation in nanoseconds. Default is 350,000,000 nanoseconds.
    ///                  Ensure this duration is longer than the animation's duration.
    ///   - animation: The animation to use when presenting the popup. Default is a spring animation.
    ///   - background: A closure returning the background content. The closure takes a Boolean indicating the presentation state.
    ///   - content: A closure returning the popup content. The closure takes the current item as a parameter.
    /// - Returns: A view with the popup applied.
    @_disfavoredOverload
    func popup<Popup: View, Background: View, Item: Identifiable & Equatable>(
        item: Binding<Item?>,
        duration nanoseconds: UInt64 = 350_000_000,
        animation: Animation = .spring(duration: 0.3, bounce: 0.25, blendDuration: 0.1),
        @ViewBuilder background: @escaping (_ isPresented: Bool) -> Background = { Color.black.opacity($0 ? 0.5 : 0) },
        @ViewBuilder content: @escaping (_ item: Item) -> Popup
    ) -> some View {
        modifier(
            PopupItemModifier(
                item: item,
                duration: nanoseconds,
                animation: animation,
                popup: content,
                background: background
            )
        )
    }

    /// Presents a popup with customizable content and background based on an identifiable item.
    ///
    /// - Note: The `duration` parameter must be greater than the `duration` of the `animation`.
    ///
    /// - Parameters:
    ///   - item: A binding to an optional identifiable item that determines whether to present the popup. The popup is presented if the item is non-nil.
    ///   - duration: The duration of the popup animation in nanoseconds. Default is 350,000,000 nanoseconds.
    ///                  Ensure this duration is longer than the animation's duration.
    ///   - delay: The amount of time (measured in nanoseconds) to wait before beginning the animations. Specify a value of 0 to begin the animations immediately.
    ///   - animation: The animation to use when presenting the popup. Default is a spring animation.
    ///   - background: A closure returning the background content. The closure takes a Boolean indicating the presentation state.
    ///   - content: A closure returning the popup content. The closure takes the current item as a parameter.
    /// - Returns: A view with the popup applied.
    @_disfavoredOverload
    func popup<Popup: View, Background: View, Item: Identifiable & Equatable>(
        item: Binding<Item?>,
        duration nanoseconds: UInt64 = 350_000_000,
        delay: UInt64,
        animation: Animation = .spring(duration: 0.3, bounce: 0.25, blendDuration: 0.1),
        @ViewBuilder background: @escaping (_ isPresented: Bool) -> Background = { Color.black.opacity($0 ? 0.5 : 0) },
        @ViewBuilder content: @escaping (_ item: Item) -> Popup
    ) -> some View {
        modifier(
            PopupItemModifier(
                item: item,
                duration: nanoseconds,
                delay: delay,
                animation: animation,
                popup: content,
                background: background
            )
        )
    }
}
