//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/14/22.
//

#if !os(macOS)
import UIKit
import AVKit

class PlayerView: UIView {

    var playerLayer: AVPlayerLayer {
        layer as! AVPlayerLayer
    }

    override class var layerClass: AnyClass {
        AVPlayerLayer.self
    }

    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
}
#endif
