//
//  AppBackGround.swift
//  ZEEW_IOS
//
//  Created by Usef on 07/05/2025.
//

import SwiftUI

struct AppBackGround: View {
    var body: some View {
        VStack {
            UnevenRoundedRectangle(
                cornerRadii: RectangleCornerRadii(
                    topLeading: 0,
                    bottomLeading: 30,
                    bottomTrailing: 30,
                    topTrailing: 0
                )
            )
            .foregroundStyle(
                LinearGradient(
                    colors: [.clear, .green.opacity(0.6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(height: 100)
            Spacer()
        }
    }
}

#Preview {
    AppBackGround()
}
