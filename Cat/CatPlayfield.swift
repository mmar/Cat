//
//  CatPlayfield.swift
//  Cat
//
//  Created by Matusalem Marques on 2017/02/28.
//

import Foundation

protocol CatPlayfield {
    var catPosition : NSPoint { get set }
    var destination : NSPoint { get }
    var catCanMove : Bool { get }
}
