
//
//  GameScene2.swift
//  BountySpinImage
//
//  Created by justin fluidity on 6/29/17.
//  Copyright © 2017 justin fluidity. All rights reserved.
//


import SpriteKit
// MARK: - Setup:
class GameScene2: SKScene {
 
  var textures = [SKTexture]()
  let sprite = SKSpriteNode()
  let label  = SKLabelNode()
  let spinSpeed = TimeInterval(0.25)
  
  var didClicklabel = false
  
  override func didMove(to view: SKView) {
    anchorPoint = CGPoint(x: 0.5, y: 0.5)
  
    // load label button:
    label.text = "auto-spin sculpture"
    label.position.y = (frame.maxY - label.frame.height) - x15
    addChild(label)
    
    // load textures:
    for i in 0...6 {
     textures.append(SKTexture(imageNamed: "img_\(i)"))
    }
    
    // load sprite:
    sprite.texture = textures.first!
    sprite.size = textures.first!.size()
    addChild(sprite)
  }
}

// MARK: - Image manipulation
extension GameScene2 {
  
  func imageUp() {
    let index = textures.index(of: sprite.texture!)
    if index == textures.count - 1 {
		    sprite.texture = textures[0]
    }
    else {
		    sprite.texture =  textures[index! + 1]
    }
  }
  
  func imageDown() {
    let index = textures.index(of: sprite.texture!)
    if index == 0 {
		    sprite.texture = textures[textures.count - 1]
    }
    else {
		    sprite.texture =  textures[index! - 1]
    }
  }
  
  func changeImage(_ isUp: Bool, _ amountOfTime: CGFloat) {
    let wait = SKAction.wait(forDuration: TimeInterval(amountOfTime))
    if isUp {
		    run(wait) {
          self.imageUp()
		    }
    }
    else {
		    run(wait) {
          self.imageDown()
		    }
    }
  }
  
  
}

// MARK: - Touches:
extension GameScene2 {
  
  enum Direction { case left, right }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    sprite.removeAllActions()
    
   if nodes(at: touches.first!.location(in: self)).contains(label) {
    didClicklabel = true
    sprite.run(.repeatForever(.animate(with: textures, timePerFrame: spinSpeed)))
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    didClicklabel = false
  }
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touch = touches.first!
    
    let dx: Direction
  
    let (thisLoc, prevLoc) = (touch.location(in: self), touch.previousLocation(in: self))
    
    guard thisLoc.x != prevLoc.x else { return }
    
    if (thisLoc.x > prevLoc.x) { dx = .right }
    else { dx = .left }
    
    if dx == .right { imageDown() }
    else { imageUp() }
  }
}
