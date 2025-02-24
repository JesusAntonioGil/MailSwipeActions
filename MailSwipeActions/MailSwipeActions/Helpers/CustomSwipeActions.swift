//
//  CustomSwipeActions.swift
//  MailSwipeActions
//
//  Created by Jesus Antonio Gil on 24/2/25.
//

import SwiftUI


struct Action: Identifiable {
    var id: String = UUID().uuidString
    var symbolImage: String
    var tint: Color
    var background: Color
    // Properties
    var font: Font = .title3
    var size: CGSize = .init(width: 45, height: 45)
    var shape: some Shape = .circle
    var action: (inout Bool) -> ()
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
    // View Properties
    @State private var resetPositionTrigger: Bool = false
    
    
    func body(content: Content) -> some View {
        content
            .overlay {
                Rectangle()
                    .fill(.clear)
                    .containerRelativeFrame(config.occupiesFullWidth ? .horizontal : .init())
                    .overlay(alignment: .trailing) {
                        ActionsView()
                    }
            }
    }
    
    
    @ViewBuilder
    func ActionsView() -> some View {
        ZStack {
            ForEach(actions.indices, id: \.self) { index in
                let action = actions[index]
                
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    Button(action: { action.action(&resetPositionTrigger) }) {
                        Image(systemName: action.symbolImage)
                            .font(action.font)
                            .foregroundStyle(action.tint)
                            .frame(width: size.width, height: size.height)
                            .background(action.background, in: action.shape)
                    }
                }
                .frame(width: action.size.width, height: action.size.height)
            }
        }
        .visualEffect { content, proxy in
            content
                .offset(x: proxy.size.width)
        }
    }
}


#Preview {
    ContentView()
}
