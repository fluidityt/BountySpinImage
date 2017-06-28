//
//  GameScene.swift
//  BountySpinImage
//
//  Created by justin fluidity on 6/27/17.
//  Copyright © 2017 justin fluidity. All rights reserved.
//

import SpriteKit
import GameplayKit


/*
 func imageDown() {
 let index = textures.indexof(sprite.texture)
 if index == 0 {
 sprite.texture = textures[textures.count - 1]
 }
 else {
 sprite.texture =  textures[index - 1]
 }
 }
 */

class GameScene: SKScene {
  
  enum Direction { case left, right }

  var oldTextures = [SKTexture]()
  var textures = [SKTexture]()
  var sprite = SKSpriteNode()
  var spinning = Direction.left
  
  func spinLeft(timePerFrame: TimeInterval) {
    // Left is ascending
    
    let oldTextures = textures
    textures = []
    
    for _ in 0...6 {
      
      var index = oldTextures.index(of: sprite.texture!)
      if index == (oldTextures.count - 1) { index = 0 } else { index! += 1 }
      
      let nextTexture = oldTextures[index!]
      textures.append(nextTexture)
      sprite.texture = nextTexture
    }
    
    let action = SKAction.repeatForever(.animate(with: textures, timePerFrame: timePerFrame))
    sprite.run(action)
  }
  
  func spinRight(timePerFrame: TimeInterval) {
    // Right is descending
    
    let oldTextures = textures
    textures = []
    
    for _ in 0...6 {
      
      var index = oldTextures.index(of: sprite.texture!)
      if index == 0 { index = (oldTextures.count - 1) } else { index! -= 1 }
      
      let nextTexture = oldTextures[index!]
      textures.append(nextTexture)
      sprite.texture = nextTexture
    }
    
    let action = SKAction.repeatForever(.animate(with: textures, timePerFrame: timePerFrame))
    sprite.run(action)
  }
  
  override func didMove(to view: SKView) {
    removeAllChildren()
    
    for i in 0...6 {
      textures.append(SKTexture(imageNamed: "img_\(i)"))
    }
    sprite.texture = textures.first!
    sprite.size = textures.first!.size()
    addChild(sprite)
    spinLeft(timePerFrame: 0.25)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    spinRight(timePerFrame: 0.25)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    spinLeft(timePerFrame: 0.25)
  }
}
