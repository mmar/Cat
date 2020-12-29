//
//  CatIsScratching.swift
//  Cat
//
//  Created by Matusalem Marques on 2017/02/28.
//  Copyright © 2017 Matusalem Marques. All rights reserved.
//

import SpriteKit
import GameplayKit

class CatIsScratching : CatState { // kaki
    override init(sprite: SKSpriteNode, playfield: CatPlayfield, textures: SKTextureAtlas) {
        super.init(sprite: sprite, playfield: playfield, textures: textures)
        validNextStates = [ CatIsAwake.self, CatIsYawning.self ]
        nextState = CatIsYawning.self
        action = SKAction.repeatForever(SKAction.animate(with: ["kaki1", "kaki2"].map { self.textures.textureNamed($0) }, timePerFrame: self.timePerFrame))
    }
}
