//
//  BackTheme.swift
//  Know-howForSwift
//
//  Created by R on 2025/05/23.
//

import SwiftUI

struct ZBack<V: View>: ViewModifier {

    var view: V

    init(@ViewBuilder view: () -> V) {
        self.view = view()
    }

    func body(content: Content) -> some View {
        ZStack {
            view
            content
        }
    }
}

extension View {
    func backTheme<T: View>(_ view: @escaping () -> T) -> ModifiedContent<Self, ZBack<T>> {
        modifier(ZBack(view: view))
    }
}

#Preview {
    Text("Hello, World!")
        .backTheme{Image("Background")}
}
