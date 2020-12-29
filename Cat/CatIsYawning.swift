//
//  CatIsYawning.swift
//  Cat
//
//  Created by Matusalem Marques on 2017/02/28.
//  Copyright © 2017 Matusalem Marques. All rights reserved.
//

import SpriteKit
import GameplayKit

class CatIsYawning : CatState { // akubi
    override init(sprite: SKSpriteNode, playfield: CatPlayfield, textures: SKTextureAtlas) {
        super.init(sprite: sprite, playfield: playfield, textures: textures)
        validNextStates = [ CatIsAwake.self, CatIsScratching.self, CatIsSleeping.self ]
        nextState = CatIsSleeping.self
        action = SKAction.setTexture(self.textures.textureNamed("mati3"))
    }
}
