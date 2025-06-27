//
//  ViewModifiers+Extension.swift
//  Jahzeen-SwiftUI
//
//  Created by Mostafa Elemam on 01/04/2025.
//

import SwiftUI

// MARK: - Custom Font

struct CustomFontModifier: ViewModifier {
    let font: GothamFont
    let size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom(font.rawValue, size: size))
    }
}
// MARK: - OnFirst Appear
struct OnFirstAppearViewModifier: ViewModifier {
    
    @State private var didAppear: Bool = false
    let action: @MainActor () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard !didAppear else { return }
                didAppear = true
                action()
            }
    }
}

// MARK: - OnFirstDisappear

struct OnFirstDisappearViewModifier: ViewModifier {
    
    @State private var didDisappear: Bool = false
    let action: @MainActor () -> Void
    
    func body(content: Content) -> some View {
        content
            .onDisappear {
                guard !didDisappear else { return }
                didDisappear = true
                action()
            }
    }
}

// MARK: - Notification Listener

struct AnyNotificationListenerViewModifier: ViewModifier {
    
    let notificationName: Notification.Name
    let onNotificationRecieved: @MainActor (Notification) -> Void
    
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: notificationName), perform: { notification in
                onNotificationRecieved(notification)
            })
    }
}

