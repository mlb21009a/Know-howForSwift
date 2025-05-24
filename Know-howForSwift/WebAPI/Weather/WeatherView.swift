//
//  WeatherView.swift
//  Know-howForSwift
//
//  Created by R on 2025/05/23.
//

import SwiftUI

struct WeatherView: View {
    @State private var response: WeatherResponse?

    var body: some View {
        ZStack {
            LinearGradient(gradient:
                            Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]), startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)

            VStack {
                Text(response?.title ?? "")
                NavigationStack {
                    ForEach(response?.forecasts ?? [], id: \.dateLabel) { forecast in
                        NavigationLink {
                            if let description = response?.description {
                                WeatherDetailView(detail: description)
                            }
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(forecast.dateLabel)
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    Text(forecast.telop)
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.7))
                                }
                                .padding()
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white.opacity(0.2))
                                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
                            )
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        }
                    }
                }
                Spacer()
            }

            if response == nil {
                ProgressView()
            }
        }
        .backTheme{
            Image("Background")
        }
        .task {
            do {
                response = try await WeatherRequest().request()

            } catch {
                print(error)
                if let error = error as? APIError {
                    switch error {
                    case .status(let code):
                        print(code)
                    case .other(let error):
                        print(error)
                        print((error as? URLError)?.code)
                    case .unknown:
                        break
                    }
                }

            }
        }
    }
}

#Preview {
    WeatherView()
}
