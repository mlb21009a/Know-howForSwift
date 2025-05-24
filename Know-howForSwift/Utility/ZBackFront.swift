//
//  BackTheme.swift
//  Know-howForSwift
//
//  Created by R on 2025/05/23.
//

import SwiftUI

struct ZBackFront<BV: View, FV: View>: ViewModifier {
    
    var back: BV
    var front: FV
    
    init(@ViewBuilder back: () -> BV, @ViewBuilder front: () -> FV) {
        self.back = back()
        self.front = front()
    }
    
    func body(content: Content) -> some View {
        ZStack {
            back
            content
            front
        }
    }
}

extension View {
    func zStack<T: View, S: View>(@ViewBuilder back: () -> T, @ViewBuilder front: () -> S) -> ModifiedContent<Self, ZBackFront<T, S>> {
        modifier(ZBackFront(back: back, front: front))
    }
}

#Preview {
    Text("Hello, World!")
        .zStack {
            Image("Background")
        } front: {
            Image("Background")
        }
    
}
