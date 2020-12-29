//
//  CatState.swift
//  Cat
//
//  Created by Matusalem Marques on 2017/02/17.
//

import SpriteKit
import GameplayKit

class CatState : GKState {
    var sprite : SKSpriteNode
    var playfield : CatPlayfield
    var textures: SKTextureAtlas
    
    var time : TimeInterval = 0.0
    var timePerFrame : TimeInterval = 0.125
    var timeBeforeNextState : TimeInterval = 2.0
    var distanceBeforeWakingUp : CGFloat = 16.0

    var validNextStates = [AnyClass]()
    var nextState : AnyClass?
    
    var action : SKAction! = nil
    
    init(sprite: SKSpriteNode, playfield: CatPlayfield, textures: SKTextureAtlas) {
        self.sprite = sprite
        self.playfield = playfield
        self.textures = textures
    }
    
    override func didEnter(from previousState: GKState?) {
        time = 0.0
        sprite.removeAllActions()
        sprite.run(action)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        guard let stateMachine = stateMachine else { return }
        time += seconds
        
        let origin = playfield.catPosition
        let destination = playfield.destination
        let distance = hypot(destination.x - origin.x, destination.y - origin.y)
        
        if playfield.catCanMove && distance > distanceBeforeWakingUp {
            stateMachine.enter(CatIsAwake.self)
        } else if let nextState = nextState, time >= timeBeforeNextState {
            stateMachine.enter(nextState.self)
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return validNextStates.contains { $0 == stateClass }
    }
}



