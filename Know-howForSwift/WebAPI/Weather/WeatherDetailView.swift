//
//  WeatherDetailView.swift
//  Know-howForSwift
//
//  Created by R on 2025/05/23.
//

import SwiftUI

struct WeatherDetailView: View {
    
    var detail: WeatherResponse.Description
    var body: some View {
        VStack {
            Text(detail.bodyText)
            Spacer()
        }
        .zStack {
            LinearGradient(gradient:
                            Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]), startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
        } front: {
        }
    }
}

#Preview {
    WeatherDetailView(detail: .init(bodyText: "ああああ"))
}
