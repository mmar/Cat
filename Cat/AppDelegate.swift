//
//  AppDelegate.swift
//  Cat
//
//  Created by Matusalem Marques on 2017/02/17.
//

import Cocoa
import SpriteKit
import GameplayKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window : NSWindow!
    var timer : Timer!
    var stateMachine : GKStateMachine!
    var catSprite : SKSpriteNode!
    
    var skinName : String = UserDefaults.standard.string(forKey: "skinName") ?? "White Cat" {
        didSet {
            for menu in [skinMenu, barSkinMenu, dockSkinMenu] {
                for item in menu!.items {
                    item.state = (item.representedObject as? String) == skinName ? .on : .off
                }
            }
        }
    }
    
    @IBOutlet var menu : NSMenu!
    
    @IBOutlet var skinMenu : NSMenu! {
        didSet {
            for item in skinMenu.items {
                item.state = (item.representedObject as? String) == skinName ? .on : .off
            }
        }
    }
    
    @IBOutlet var barSkinMenu : NSMenu! {
        didSet {
            for item in barSkinMenu.items {
                item.state = (item.representedObject as? String) == skinName ? .on : .off
            }
        }
    }
    
    @IBOutlet var dockMenu : NSMenu!
    
    @IBOutlet var dockSkinMenu : NSMenu! {
        didSet {
            for item in dockSkinMenu.items {
                item.state = (item.representedObject as? String) == skinName ? .on : .off
            }
        }
    }
    
    @IBAction func setSkin(_ sender: NSMenuItem) {
        guard let skinName = sender.representedObject as? String else { return }
        self.skinName = skinName
        UserDefaults.standard.set(skinName, forKey: "skinName")
        
        let catTextures = SKTextureAtlas(named: skinName)
        stateMachine = createStateMachine(sprite: catSprite, textures: catTextures)
    }
    
    func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        return dockMenu
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let rect = NSRect(x: 0, y: 0, width: 64, height: 64)
        
        let catTextures = SKTextureAtlas(named: skinName)
        
        catSprite = SKSpriteNode(texture: catTextures.textureNamed("awake"))
        
        catSprite.anchorPoint = NSPoint.zero

        let scene = SKScene(size: rect.size)
        scene.backgroundColor = NSColor.clear
        scene.addChild(catSprite)
        
        let spriteView = SKView()
        spriteView.allowsTransparency = true
        spriteView.presentScene(scene)
        
        spriteView.menu = menu
        
        window = NSWindow(contentRect: rect, styleMask: .borderless, backing: .buffered, defer: false)
        window.backgroundColor = NSColor.clear
        window.hasShadow = false  // Shadow is not updated when sprite changes
        window.isMovableByWindowBackground = true
        window.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.statusWindow))) // Over all windows and menu bar, but under the screen saver
        window.ignoresMouseEvents = false
        window.collectionBehavior = [.canJoinAllSpaces,.stationary]
        window.contentView = spriteView
        window.center()
    
        let windowController = NSWindowController(window: window)
        windowController.showWindow(self)

        stateMachine = createStateMachine(sprite: catSprite, textures: catTextures)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        timer.invalidate()
    }
    
    func createStateMachine(sprite: SKSpriteNode, textures: SKTextureAtlas) -> GKStateMachine {
        if timer != nil {
            timer.invalidate()
        }
        
        let catStates = [
            CatIsStopped(sprite: sprite, playfield: self, textures: textures),
            CatIsLicking(sprite: sprite, playfield: self, textures: textures),
            CatIsScratching(sprite: sprite, playfield: self, textures: textures),
            CatIsYawning(sprite: sprite, playfield: self, textures: textures),
            CatIsSleeping(sprite: sprite, playfield: self, textures: textures),
            CatIsAwake(sprite: sprite, playfield: self, textures: textures),
            CatIsMoving(sprite: sprite, playfield: self, textures: textures)
        ]
        let stateMachine = GKStateMachine(states: catStates)
        stateMachine.enter(CatIsAwake.self)
        
        if #available(OSX 10.12, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 0.125, repeats: true) { timer in
                self.stateMachine.update(deltaTime: timer.timeInterval)
            }
        } else {
            timer = Timer.scheduledTimer(timeInterval: 0.125, target: self, selector: #selector(updateStateMachine), userInfo: nil, repeats: true)
        }
        RunLoop.current.add(timer, forMode: .common)
        
        return stateMachine
    }
    
    @objc func updateStateMachine() {
        self.stateMachine.update(deltaTime: timer.timeInterval)
    }
}

extension SKView {
    open override func rightMouseDown(with event: NSEvent) {
        super.rightMouseDown(with: event)
    }
}

extension AppDelegate : CatPlayfield {
    var catPosition : NSPoint {
        get { return window.frame.origin }
        set { window.setFrameOrigin(newValue) }
    }
    
    var destination : NSPoint {
        let mousePosition = NSEvent.mouseLocation
        return NSPoint(x: mousePosition.x - 32, y: mousePosition.y + 4)
    }
    
    var catCanMove : Bool {
        return !window.frame.contains(NSEvent.mouseLocation)
    }
}

