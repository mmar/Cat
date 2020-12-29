//
//  CatIsLicking.swift
//  Cat
//
//  Created by Matusalem Marques on 2017/02/28.
//

import SpriteKit
import GameplayKit

class CatIsLicking : CatState { // jare
    override init(sprite: SKSpriteNode, playfield: CatPlayfield, textures: SKTextureAtlas) {
        super.init(sprite: sprite, playfield: playfield, textures: textures)
        validNextStates = [ CatIsAwake.self, CatIsScratching.self ]
        nextState = CatIsScratching.self
        action = SKAction.repeatForever(SKAction.animate(with: ["jare2", "mati2"].map { self.textures.textureNamed($0) }, timePerFrame: self.timePerFrame))
    }
}
