import SwiftUI

extension Binding {
    func isPresented<Wrapped>() -> Binding<Bool> where Value == Wrapped? {
        .init(
            get: { self.wrappedValue != nil },
            set: { isPresent in
                guard !isPresent else { return }
                self.wrappedValue = nil
            }
        )
    }
}
