//
//  CatIsAwake.swift
//  Cat
//
//  Created by Matusalem Marques on 2017/02/28.
//

import SpriteKit
import GameplayKit

class CatIsAwake : CatState {
    var timeBeforeMoving : TimeInterval = 0.250
    var distanceBeforeMoving : CGFloat = 16.0
    
    override init(sprite: SKSpriteNode, playfield: CatPlayfield, textures: SKTextureAtlas) {
        super.init(sprite: sprite, playfield: playfield, textures: textures)
        validNextStates = [ CatIsMoving.self, CatIsStopped.self ]
        action = SKAction.setTexture(self.textures.textureNamed("awake"))
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        guard let stateMachine = stateMachine else { return }
        time += seconds
        
        let origin = playfield.catPosition
        let destination = playfield.destination
        let distance = hypot(destination.x - origin.x, destination.y - origin.y)
        
        if distance >= distanceBeforeMoving && time >= timeBeforeMoving {
            stateMachine.enter(CatIsMoving.self)
        } else if time >= timeBeforeNextState {
            stateMachine.enter(CatIsStopped.self)
        }
    }
}
