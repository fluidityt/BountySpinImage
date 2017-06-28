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
      
      // Left spin is ascending indices, right spin is descending indices:
      var initialTextures = [SKTexture]()
      
      // Reset then reload this from 0-6 with the correct image sequences from initialTextures:
      var nextTextures = [SKTexture]()
      
      var sprite = SKSpriteNode()
      
      // Use gesture recognizer or other means to set how fast the spin should be.
      var velocity = TimeInterval(0.1)
      
      enum Direction { case left, right }
      
      func spin(direction: Direction, timePerFrame: TimeInterval) {
        
        nextTextures = []
        for _ in 0...6 {

          var index = initialTextures.index(of: sprite.texture!)
          
          // Left is ascending, right is descending:
          switch direction {
          case .left:
            if index == (initialTextures.count - 1) { index = 0 } else { index! += 1 }
          case .right:
            if index == 0 { index = (initialTextures.count - 1) } else { index! -= 1 }
          }
          
          let nextTexture = initialTextures[index!]
          nextTextures.append(nextTexture)
          sprite.texture = nextTexture
        }
        
        let action = SKAction.repeatForever(.animate(with: nextTextures, timePerFrame: timePerFrame))
        sprite.run(action)
      }
      
      override func didMove(to view: SKView) {
        removeAllChildren()
        
        // Make our textures for spinning:
        for i in 0...6 {
          initialTextures.append(SKTexture(imageNamed: "img_\(i)"))
        }
        nextTextures = initialTextures
        
        sprite.texture = nextTextures.first!
        sprite.size = nextTextures.first!.size()
        addChild(sprite)
        spin(direction: .left, timePerFrame: 0.10)
      }
      
      override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        spin(direction: .right, timePerFrame: velocity)
      }
      
      override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        spin(direction: .left, timePerFrame: velocity)
      }
    }
