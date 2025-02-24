//
//  PanGesture.swift
//  MailSwipeActions
//
//  Created by Jesus Antonio Gil on 24/2/25.
//

import SwiftUI


struct PanGestureValue {
    var translation: CGSize = .zero
    var velocity: CGSize = .zero
}


struct PanGesture: UIGestureRecognizerRepresentable {
    var onBegan: () -> ()
    var onChange: (PanGestureValue) -> ()
    var onEnded: (PanGestureValue) -> ()
    
    
    func makeCoordinator(converter: CoordinateSpaceConverter) -> Coordinator {
        Coordinator()
    }
    
    func makeUIGestureRecognizer(context: Context) -> some UIGestureRecognizer {
        let gesture = UIPanGestureRecognizer()
        gesture.delegate = context.coordinator
        return gesture
    }
    
    func updateUIGestureRecognizer(_ recognizer: UIGestureRecognizerType, context: Context) {
        
    }
    
    func handleUIGestureRecognizerAction(_ recognizer: UIPanGestureRecognizer, context: Context) {
        let state = recognizer.state
        let translation = recognizer.translation(in: recognizer.view).toSize
        let velocity = recognizer.velocity(in: recognizer.view).toSize
        
        let gestureValue = PanGestureValue(translation: translation, velocity: velocity)
        
        switch state {
            case .began: onBegan()
            case .changed: onChange(gestureValue)
            case .ended, .cancelled: onEnded(gestureValue)
            default: break
        }
    }
    
    
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            if let panGesture = gestureRecognizer as? UIPanGestureRecognizer {
                let velocity = panGesture.velocity(in: panGesture.view)
                
                
            }
        }
    }
}


extension CGPoint {
    var toSize: CGSize {
        return CGSize(width: x, height: y)
    }
}
