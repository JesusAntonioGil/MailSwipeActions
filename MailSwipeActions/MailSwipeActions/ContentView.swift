//
//  ContentView.swift
//  MailSwipeActions
//
//  Created by Jesus Antonio Gil on 22/2/25.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    ForEach(1...100, id: \.self) { _ in
                        Rectangle()
                            .fill(.black.gradient)
                            .frame(height: 50)
                            .swipeActions {
                                Action(symbolImage: "square.and.arrow.up.fill", tint: .white, background: .blue) { resetPosition in
                                    resetPosition.toggle()
                                }
                                
                                Action(symbolImage: "square.and.arrow.down.fill", tint: .white, background: .purple) { resetPosition in
                                    
                                }
                                
                                Action(symbolImage: "trash.fill", tint: .white, background: .red) { resetPosition in
                                    
                                }
                            }
                    }
                }.padding(15)
            }
            .navigationTitle("Custom Swipe Actions")
        }
    }
}


#Preview {
    ContentView()
}
