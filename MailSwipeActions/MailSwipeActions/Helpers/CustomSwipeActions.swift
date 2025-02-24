//
//  CustomSwipeActions.swift
//  MailSwipeActions
//
//  Created by Jesus Antonio Gil on 24/2/25.
//

import SwiftUI


struct Action: Identifiable {
    let id: String = UUID().uuidString
    let symbolImage: String
    let tint: Color
    let background: Color
    // Properties
    let font: Font = .title3
    let size: CGSize = .init(width: 45, height: 45)
    let shape: some Shape = .circle
    let action: (inout Bool) -> ()
}


@resultBuilder
struct ActionBuilder {
    static func buildBlock(_ components: Action...) -> [Action] {
        return components
    }
}


struct ActionConfig {
    let leadingPadding: CGFloat = 0
    let trailingPadding: CGFloat = 10
    let spacing: CGFloat = 10
    let occupiesFullWidth: Bool = true
}


extension View {
    @ViewBuilder
    func swipeActions(config: ActionConfig = .init(), @ActionBuilder actions: () -> [Action]) -> some View {
        self
            .modifier(CustomSwipeActionModifier(config: config, actions: actions()))
    }
}


fileprivate struct CustomSwipeActionModifier: ViewModifier {
    let config: ActionConfig
    let actions: [Action]
    
    func body(content: Content) -> some View {
        content
    }
}
