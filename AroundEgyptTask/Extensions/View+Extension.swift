//
//  View+Extension.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import Foundation

import SwiftUI

extension View {
    
    func customFont(_ font: GothamFont, size: CGFloat) -> some View {
        modifier(CustomFontModifier(font: font, size: size))
    }
    func redacted(_ enable: Bool, style: RedactedStyle = .placeholder) -> some View {
        modifier(RedactedViewModifier(isRedacted: enable, style: style))
    }
}
