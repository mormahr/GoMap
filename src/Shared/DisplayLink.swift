//  Converted to Swift 5.4 by Swiftify v5.4.27034 - https://swiftify.com/
//
//  DisplayLink.swift
//  Go Map!!
//
//  Created by Bryce Cogswell on 10/9/14.
//  Copyright (c) 2014 Bryce Cogswell. All rights reserved.
//

import Foundation
import CoreVideo

@objcMembers
class DisplayLink: NSObject{
    
#if os(iOS)
    var _displayLink: CADisplayLink?
#else
    var _displayLink: CVDisplayLink?
#endif
    var blockDict: NSMutableDictionary?
    
    private static let g_shared = DisplayLink()
    
    class func shared() -> DisplayLink? {
        // `dispatch_once()` call was converted to a static variable initializer
        return g_shared
    }
    
    override init() {
        super.init()
#if os(iOS)
        _displayLink = CADisplayLink(target: self, selector: #selector(update(_:)))
        _displayLink?.isPaused = true
        _displayLink?.add(to: RunLoop.main, forMode: .default)
#else
        let displayID = CGMainDisplayID()
        CVDisplayLinkCreateWithCGDisplay(displayID, &displayLink)
        CVDisplayLinkSetOutputCallback(displayLink, displayLinkCallback, &self)
#endif
    }
    
    @objc func update(_ displayLink: CADisplayLink?) {
        blockDict?.enumerateKeysAndObjects({ name, block, stop in
            if let block = block as? (() -> ()) {
                block()
            }
        })
    }
    
#if os(iOS)
#else
    func displayLinkOutputCallback(displayLink: CVDisplayLink, _ inNow: UnsafePointer<CVTimeStamp>, _ inOutputTime: UnsafePointer<CVTimeStamp>, _ flagsIn: CVOptionFlags, _ flagsOut: UnsafeMutablePointer<CVOptionFlags>, _ displayLinkContext: UnsafeMutablePointer<Void>) -> CVReturn {
        let myself = displayLinkContext as? DisplayLink
        myself?.update(nil)
    }
#endif
    
    func duration() -> Double {
#if os(iOS)
        return _displayLink?.duration ?? 0
#else
        return CVDisplayLinkGetActualOutputVideoRefreshPeriod(displayLink)
#endif
    }
    
    func timestamp() -> CFTimeInterval {
#if os(iOS)
        return _displayLink?.timestamp ?? 0
#else
        return CACurrentMediaTime()
#endif
    }
    
    func addName(_ name: NSString, block: @escaping () -> Void) {
        blockDict?.setObject(block, forKey: name)
#if os(iOS)
        _displayLink?.isPaused = false
#else
        CVDisplayLinkStart(displayLink)
#endif
    }
    
    func hasName(_ name: String) -> Bool {
        return blockDict?[name] != nil
    }
    
    func removeName(_ name: String) {
        blockDict?.removeObject(forKey: name)
        
        if blockDict?.count == 0 {
#if os(iOS)
            _displayLink?.isPaused = true
#else
            CVDisplayLinkStop(displayLink)
#endif
        }
    }
    
    deinit {
#if os(iOS)
        _displayLink?.remove(from: RunLoop.main, forMode: .default)
#else
        CVDisplayLinkRelease(displayLink)
#endif
    }
}
