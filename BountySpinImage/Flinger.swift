//
//  Flinger.swift
//  BountySpinImage
//
//  Created by justin fluidity on 6/28/17.
//  Copyright © 2017 justin fluidity. All rights reserved.
//

import SpriteKit

// MARK: - Flinger:
class Flinger {
  
  init(width: CGFloat) { self.width = width }
  
  let width: CGFloat
  
  var shouldFling = false
  
  var locations = [CGPoint]()
  
  let maxDistanceToFling = CGFloat(5) // Percentage of total width
  
  // Called after touchesMoved (in gamescene .update)
  func update(frame: Int, location: CGPoint) {
    locations.append(location)
    
    guard locations.count >= 2 else { return }
    
    // Need to adjust for total width (-1,0 vs 1,0 issues)
    let index  = locations.count - 1
    let prevDX = (locations[index - 2].x - locations[index - 1].x) + width/2
    let curDX  = (locations[index].x     - locations[index - 1].x) + width/2
    
    // if both are positive or negative, carry on, if different reset velocity checker.
    // Need to handle case of dx of 0 before here?
    guard (curDX > 0 && prevDX > 0) || (curDX < 0 && prevDX < 0) else {
      locations = [locations[index], locations[index - 1]]
      
      return
    }
    
    // What goes here?
    
    // hey, so it flings after X distance or X acceleration, and if your finger stops
    // then it autofires (instead of waiting for touchesended)
  }
  
  func read() -> (dir: Direction, vel: CGFloat)? {
    guard locations.count >= 2 else { return nil }
    
    var returnDirection: Direction
    
    
    
    return(.left, 0)
  }
  
  func reset() {
    locations = []
   // frameStart = 0
    //frameEnd = 0
  }
  
}
