//
//  CustomTextFieldSUI.swift
//  Movarium
//
//  Created by Anton Solovev on 20.10.2024.
//

import SwiftUI

struct CustomTextFieldView: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.grayFaded)
            }
            TextEditor(text: $text)
                .foregroundColor(.textDefault)
                .lineLimit(0)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .padding(.vertical, -8)
                .padding(.horizontal, -6)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding(16)
        .frame(maxHeight: 120)
        .background(Color.darkFaded)
        .cornerRadius(8)
    }
}
