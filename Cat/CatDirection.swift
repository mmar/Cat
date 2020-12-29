//
//  CatDirection.swift
//  Cat
//
//  Created by Matusalem Marques on 2017/02/28.
//

import Foundation

enum CatDirection : Int {
    case up
    case down
    case left
    case right
    case upLeft
    case upRight
    case downLeft
    case downRight
    
    init(vector: NSPoint) {
        let angle = Double(atan2(vector.y, vector.x))
        
        switch(angle) {
        case (-7/8 * .pi)...(-5/8 * .pi):
            self = .downLeft
        case (-5/8 * .pi)...(-3/8 * .pi):
            self = .down
        case (-3/8 * .pi)...(-1/8 * .pi):
            self = .downRight
        case (-1/8 * .pi)...(1/8 * .pi):
            self = .right
        case (1/8 * .pi)...(3/8 * .pi):
            self = .upRight
        case (3/8 * .pi)...(5/8 * .pi):
            self = .up
        case (5/8 * .pi)...(7/8 * .pi):
            self = .upLeft
        default:
            self = .left
        }
    }
    
    static func squared(vector: NSPoint) -> CatDirection {
        let angle = Double(atan2(vector.y, vector.x))
        
        switch(angle) {
        case (-3/4 * .pi)...(-1/4 * .pi):
            return .down
        case (-1/4 * .pi)...(1/4 * .pi):
            return .right
        case (1/4 * .pi)...(3/4 * .pi):
            return .up
        default:
            return .left
        }
    }
}
