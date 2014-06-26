//
//  GameScene.swift
//  SuperCat
//
//  Created by Sami Purmonen on 2014-06-13.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    var hero = SKSpriteNode()
    let touchActionName = "tidiula"
    
    let heroCategory: UInt32 = 1
    let terrainCategory: UInt32 = 1 << 1
    
    var crashCount = 0
    
    var crashLabel = SKLabelNode()
    
    var topTerrain = SKShapeNode()
    var bottomTerrain = SKShapeNode()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        scene.backgroundColor=SKColor(red: 0.6, green: 0.8, blue: 1, alpha: 1)
        crashLabel.position = CGPointMake(80, self.frame.height - 100)
        crashLabel.fontColor = SKColor.blackColor()
        self.addChild(crashLabel)
        scene.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
        self.physicsWorld.contactDelegate = self
        hero = scene.childNodeWithName("hero") as SKSpriteNode
        hero.physicsBody.friction = 10
        hero.physicsBody.categoryBitMask = heroCategory
        hero.physicsBody.collisionBitMask = terrainCategory
        hero.physicsBody.contactTestBitMask = terrainCategory
        
        reset()
    }
    
    func reset() {
        self.removeChildrenInArray([topTerrain, bottomTerrain])
        crashCount = 0
        updateCrashLabel()
        makeTerrain3()
    }
    
    func makeTerrain()  {
        var bottomPath = CGPathCreateMutable()
        var topPath = CGPathCreateMutable()
        
        let scale = 500
        let pointCount = scale
        let maxHeight = 300
        let minSplit = Int(self.frame.height * 0.3)
        let randomSplit=500
        let width = self.frame.width / CGFloat(pointCount - 1) * CGFloat(scale)
        
        CGPathMoveToPoint(bottomPath, nil, 0, 0)
        CGPathMoveToPoint(topPath, nil, 0, self.frame.height)
        
        for i in 0..pointCount {
            let x = CGFloat(i) * width
            var y = CGFloat(Int(arc4random()) % maxHeight)
            CGPathAddLineToPoint(bottomPath, nil, x, y)
            var split=200
            y=y+CGFloat( minSplit+(Int(arc4random()) % randomSplit))
            CGPathAddLineToPoint(topPath,nil,x,y)
        }
        
        CGPathAddLineToPoint(bottomPath, nil, self.frame.width * CGFloat(scale), 0)
        CGPathAddLineToPoint(topPath, nil, self.frame.width * CGFloat(scale), self.frame.height)

        CGPathCloseSubpath(bottomPath)
        CGPathCloseSubpath(topPath)
        
        var moveLeftAction = SKAction.moveByX(-self.frame.width, y: 0, duration: 0.5)
        var moveShapeAction = SKAction.repeatActionForever(moveLeftAction)
        
        var isFirst = true
        for path in [bottomPath, topPath] {

            var node = SKShapeNode()
            node.path = path
            node.position = CGPointMake(0,0)
            node.fillColor = SKColor.greenColor()
            self.addChild(node)
            node.physicsBody = SKPhysicsBody(edgeLoopFromPath: node.path)
            node.physicsBody.dynamic = false
            node.physicsBody.categoryBitMask = terrainCategory
            node.runAction(moveShapeAction)
            
            if (isFirst) {
                bottomTerrain = node
            } else {
                topTerrain = node
            }
            isFirst = false
        }
    }
    
    func makeTerrain2()  {
        var bottomPath = CGPathCreateMutable()
        var topPath = CGPathCreateMutable()
        let scale = 100
        let pointCount = scale * 2
        var gapHeight = CGFloat(frame.height * 0.7)
        let lineWidth = frame.width / CGFloat(pointCount - 1) * CGFloat(scale)
        
        CGPathMoveToPoint(bottomPath, nil, 0, 0)
        CGPathMoveToPoint(topPath, nil, 0, self.frame.height)
        
        for i in 0..pointCount {
            let currentGapHeight = gapHeight - (gapHeight * CGFloat(i) / CGFloat(pointCount))
            let x = CGFloat(i) * lineWidth
            let bottomY = CGFloat(Int(arc4random()) % Int(frame.height - currentGapHeight))
            CGPathAddLineToPoint(bottomPath, nil, x, bottomY)
            
            let topY = bottomY + currentGapHeight
            CGPathAddLineToPoint(topPath, nil, x, topY)
        }
        
        CGPathAddLineToPoint(bottomPath, nil, self.frame.width * CGFloat(scale), 0)
        CGPathAddLineToPoint(topPath, nil, self.frame.width * CGFloat(scale), self.frame.height)
        
        CGPathCloseSubpath(bottomPath)
        CGPathCloseSubpath(topPath)
        
        var moveLeftAction = SKAction.moveByX(-self.frame.width, y: 0, duration: 1.5)
        var moveShapeAction = SKAction.repeatActionForever(moveLeftAction)
        
        var isFirst = true
        for path in [bottomPath, topPath] {
            
            var node = SKShapeNode()
            node.path = path
            node.position = CGPointMake(0,0)
            node.fillColor = SKColor.greenColor()
            self.addChild(node)
            node.physicsBody = SKPhysicsBody(edgeLoopFromPath: node.path)
            node.physicsBody.dynamic = false
            node.physicsBody.categoryBitMask = terrainCategory
            node.runAction(moveShapeAction)
            
            if (isFirst) {
                bottomTerrain = node
            } else {
                topTerrain = node
            }
            isFirst = false
        }
    }
    func makeTerrain3()  {
        var bottomPath = CGPathCreateMutable()
        var topPath = CGPathCreateMutable()
        let scale = 100
        let pointCount = scale * 2
        var gapHeight = CGFloat(frame.height * 0.7)
        let lineWidth = frame.width / CGFloat(pointCount - 1) * CGFloat(scale)
        
        CGPathMoveToPoint(bottomPath, nil, 0, 0)
        CGPathMoveToPoint(topPath, nil, 0, self.frame.height)
        
        for i in 0..pointCount {
            var currentGapHeight = gapHeight - (gapHeight * CGFloat(i) / CGFloat(pointCount))
            //currentGapHeight = currentGapHeight + CGFloat((sin(CGFloat(i)*0.1))*50)
            let x = CGFloat(i) * lineWidth*0.6
            var bottomY = CGFloat((sin(CGFloat(i))+1.1)*100)//cz(Int(arc4random()) % Int(frame.height - currentGapHeight))
            bottomY = bottomY + CGFloat((sin(CGFloat(i)*0.3)+1.1)*100)
            CGPathAddLineToPoint(bottomPath, nil, x, bottomY)
            
            let topY = bottomY + currentGapHeight
            CGPathAddLineToPoint(topPath, nil, x, topY)
        }
        
        CGPathAddLineToPoint(bottomPath, nil, self.frame.width * CGFloat(scale), 0)
        CGPathAddLineToPoint(topPath, nil, self.frame.width * CGFloat(scale), self.frame.height)
        
        CGPathCloseSubpath(bottomPath)
        CGPathCloseSubpath(topPath)
        
        var moveLeftAction = SKAction.moveByX(-self.frame.width, y: 0, duration: 1.5)
        var moveShapeAction = SKAction.repeatActionForever(moveLeftAction)
        
        var isFirst = true
        for path in [bottomPath, topPath] {
            
            var node = SKShapeNode()
            node.path = path
            node.position = CGPointMake(0,0)
            node.fillColor = SKColor.greenColor()
            self.addChild(node)
            node.physicsBody = SKPhysicsBody(edgeLoopFromPath: node.path)
            node.physicsBody.dynamic = false
            node.physicsBody.categoryBitMask = terrainCategory
            node.runAction(moveShapeAction)
            
            if (isFirst) {
                bottomTerrain = node
            } else {
                topTerrain = node
            }
            isFirst = false
        }

        
        let stoneRadius :CGFloat = 50
        var stone = SKShapeNode(circleOfRadius: stoneRadius)
        stone.position = CGPointMake(300, 150)
        stone.fillColor = SKColor.grayColor()
        self.addChild(stone)
        stone.physicsBody = SKPhysicsBody(circleOfRadius: stoneRadius)
        stone.physicsBody.dynamic = true
        stone.physicsBody.categoryBitMask = terrainCategory
        stone.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveByX(-self.frame.width-stoneRadius*2, y: 0, duration: 1.5),
            SKAction.runBlock({
                stone.position=CGPointMake(self.frame.width+stoneRadius-100,CGFloat(arc4random_uniform(200)+160))
                })
            ])))
        
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            var touchAction = SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.runBlock {
                        self.hero.physicsBody.applyImpulse(CGVectorMake(0, 55))
                    },
                    SKAction.waitForDuration(0.1)
                ]))
            
            hero.runAction(touchAction, withKey: touchActionName)
        }
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        hero.removeActionForKey(touchActionName)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        crashCount++
        for body in [contact.bodyA, contact.bodyB] {
            for terrain in [bottomTerrain, topTerrain] {
                if (body == terrain.physicsBody) {
                    updateCrashLabel()
                    terrain.runAction(SKAction.sequence([
                        SKAction.runBlock {
                            terrain.fillColor = SKColor.redColor()
                        },
                        SKAction.waitForDuration(1),
                        SKAction.runBlock {
                            terrain.fillColor = SKColor.greenColor()
                        },
                    ]))
                }
            }
        }
//        reset()
    }
    
    func updateCrashLabel() {
        crashLabel.text = "Crashes: \(crashCount)"
    }
    
    override func didSimulatePhysics() {
        hero.position.x=200
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
