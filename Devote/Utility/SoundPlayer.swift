//
//  SoundPlayer.swift
//  Devote
//
//  Created by Víctor Manuel Puga Ruiz on 03/04/21.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
  if let path = Bundle.main.path(forResource: sound, ofType: type) {
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      audioPlayer?.play()
    } catch {
      print("Couln't find and play sound file")
    }
  }
}
