//
//  GrayBoxSUI.swift
//  Movarium
//
//  Created by Anton Solovev on 22.10.2024.
//

import SwiftUI

struct GrayBoxView: View {
    var title: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(.darkFaded)
            .cornerRadius(16)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.custom("Manrope-Medium", size: 16))
                    .foregroundColor(.textDefault)

                Spacer()
            }
            .padding()
        }
    }
}
